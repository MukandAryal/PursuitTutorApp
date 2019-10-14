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
                if let userName = resultDict?.object(forKey: "name") as? String{
                    self.userName_lbl.text = userName
                }
                if let userEmail = resultDict?.object(forKey: "email") as? String{
                    self.userEmail_lbl.text = userEmail
                }
                if let emailVerfication = resultDict?.object(forKey: "email_verified_at") as? String{
                    
                }
            }
            else { //error
                let resultDict = response as NSDictionary?
                if let errorMsg = resultDict?.object(forKey: "message") as? String{
                   self.showAlert(message: errorMsg)
                }
            }
           // self.stopProgress()
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
