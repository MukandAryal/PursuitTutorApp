//
//  ProfileViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 27/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class ProfileViewController: BaseClassViewController {
    
    @IBOutlet weak var userName_lbl: UILabel!
    @IBOutlet weak var userEmail_lbl: UILabel!
    @IBOutlet weak var emailVerfication_Icon: UIImageView!
    @IBOutlet weak var emailVerification_btn: UIButton!
    @IBOutlet weak var profile_imgView: UIImageView!
    @IBOutlet weak var dateOfBirth_lbl: UILabel!
    @IBOutlet weak var organization_lbl: UILabel!
    var profileDetails = getAllCourse.UserDetails()
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if Connectivity.isConnectedToInternet() {
            userProfileApi()
        } else {
            showAlert(title: "No Internet!", message: "Please check your internet connection")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(profile_imgView.frame)
        profile_imgView.layer.cornerRadius = profile_imgView.frame.height/2
        profile_imgView.clipsToBounds = true
    }
    
    // MARK: - User Profile Api
    func userProfileApi(){
        // showCustomProgress()
        LoadingIndicatorView.show()
        WebserviceSigleton.shared.GETService(urlString: ApiEndPoints.user) { (response, error) in
            LoadingIndicatorView.hide()
            if error == nil {
                let resultDict = response as NSDictionary?
                print("resultDict>>>>>",resultDict as Any)
                let details = getAllCourse.UserDetails(
                    id: resultDict?.object(forKey: "id") as? Int,
                    name: resultDict?.object(forKey: "name") as? String,
                    email: resultDict?.object(forKey: "email") as? String,
                    dob: resultDict?.object(forKey: "dob") as? String,
                    profileImage: resultDict?.object(forKey: "profileImage") as? String,
                    Organization: resultDict?.object(forKey: "Organization") as? String,
                    email_verified_at: resultDict?.object(forKey: "email_verified_at") as? String,
                    role: resultDict?.object(forKey: "role") as? Int)
                if let userName = resultDict?.object(forKey: "name") as? String{
                    self.profileDetails.name = userName
                    self.userName_lbl.text = userName
                }
                if let userEmail = resultDict?.object(forKey: "email") as? String{
                    self.profileDetails.email = userEmail
                    self.userEmail_lbl.text = userEmail
                }
                if let dateOfBirth = resultDict?.object(forKey: "dob") as? String{
                    let dateFormatterGet = DateFormatter()
                    dateFormatterGet.dateFormat = "yyyy-MM-dd"
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "dd MMM yyyy"
                    if let date = dateFormatterGet.date(from:  dateOfBirth) {
                        self.dateOfBirth_lbl.text = dateFormatterPrint.string(from: date)
                        self.profileDetails.dob = dateOfBirth
                    }
                }
                if let organizationName = resultDict?.object(forKey: "Organization") as? String{
                    self.profileDetails.Organization = organizationName
                    self.organization_lbl.text = organizationName
                }
                if let emailVerfication = resultDict?.object(forKey: "email_verified_at") as? String{
                    self.profileDetails.email_verified_at = emailVerfication
                }
                if let profilePic = resultDict?.object(forKey: "profileImage") as? String{
                    self.profileDetails.profileImage = profilePic
                    let imageStr = Configurator.imageBaseUrl + profilePic
                    self.profile_imgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "demo_icon"))
                }
            }
            else { //error
                let resultDict = response as NSDictionary?
                if let errorMsg = resultDict?.object(forKey: "message") as? String{
                    self.showAlert(message: errorMsg)
                }
            }
            LoadingIndicatorView.hide()
        }
    }
    
    // MARK: - Email Verification Pop Up
    func showCustomDialog(animated: Bool = true) {
        // Create a custom view controller
        let exitVc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVerificationView") as? ProfileVerificationView
        
        
        
        // Create the dialog
        let popup = PopupDialog(viewController: exitVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        exitVc?.emailVerification_descriptionLbl.text = "You need to verify the email to enroll the \n course"
        exitVc?.emailVerification_titleLbl.text = "Email Verification"
        exitVc?.sendOtp_btn.addTargetClosure { _ in
            popup.dismiss()
            self.exitBtn()
        }
        exitVc!.notNot_btn.addTargetClosure { _ in
            popup.dismiss()
        }
        present(popup, animated: animated, completion: nil)
    }
    
    func exitBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionEdit_btn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "ProfileEditViewController") as! ProfileEditViewController
        obj.userDetails = profileDetails
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    // MARK: - Button Action
    @IBAction func action_SignOutBtn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewViewController") as! LoginViewViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func actionEmailVerfication_btn(_ sender: Any) {
        showCustomDialog()
    }
    @IBAction func actionAboutUs_btn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}
