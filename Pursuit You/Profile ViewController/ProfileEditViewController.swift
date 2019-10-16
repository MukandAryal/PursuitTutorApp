//
//  ProfileEditViewController.swift
//  Pursuit TutorApp
//
//  Created by Apple SSD2 on 14/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit
import Alamofire

class ProfileEditViewController: BaseClassViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    let datePicker = UIDatePicker()
    var picker = UIImagePickerController()
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?
    var imgToUpload = Data()
    var window: UIWindow?
    var userDetails = getAllCourse.UserDetails()
    
    
    @IBOutlet weak var name_txtFld: UITextField!
    @IBOutlet weak var dateOfBirth_txtFld: UITextField!
    @IBOutlet weak var organization_txtFld: UITextField!
    @IBOutlet weak var profile_imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        name_txtFld.text = userDetails.name
        organization_txtFld.text = userDetails.Organization
        dateOfBirth_txtFld.text = userDetails.email_verified_at
        let imageStr = Configurator.imageBaseUrl + userDetails.profileImage!
        self.profile_imgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "demo_icon"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print(profile_imgView.frame)
        profile_imgView.layer.cornerRadius = profile_imgView.frame.height/2
        profile_imgView.clipsToBounds = true
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateOfBirth_txtFld.inputAccessoryView = toolbar
        dateOfBirth_txtFld.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        datePicker.maximumDate = Date()
        dateOfBirth_txtFld.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //get image from source type
    func openCamera(){
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
            alertWarning.show()
        }
    }
    
    func openGallery(){
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }
    
    
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        profile_imgView.image = selectedImage
        if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
            imgToUpload = imageData
        }
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func profileUpdateApi(device_token:String,accept:String,name:String,dateOfBirth:String,Organization:String,profileImg:Data){
        LoadingIndicatorView.show()
        let token = Configurator.tokenBearer + (userDefault.string(forKey: userDefualtKeys.user_Token.rawValue))!
        Alamofire.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(name.data(using: String.Encoding.utf8)!, withName: "name")
            multipartFormData.append(dateOfBirth.data(using: String.Encoding.utf8)!, withName: "dob")
            multipartFormData.append(Organization.data(using: String.Encoding.utf8)!, withName: "Organization")
            if let imgToUpload = self.profile_imgView.image!.jpegData(compressionQuality: 0.2) {
                multipartFormData.append(imgToUpload, withName: "image", fileName: "\(String(NSDate().timeIntervalSince1970).replacingOccurrences(of: ".", with: "")).jpeg", mimeType: "image/jpeg")
            }
        },
                         usingThreshold:UInt64.init(),
                         to:Configurator.baseURL + ApiEndPoints.updateProfile,
                         method:.post,
                         headers:["Authorization": token,"Accept":"application/json"],
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    LoadingIndicatorView.hide()
                                    self.showCustomSucessDialog()
                                    debugPrint(response)
                                }
                            case .failure(let encodingError):
                                LoadingIndicatorView.hide()
                                print(encodingError)
                                self.showAlert(title: "Alert", message: "Please try again!")
                            }
        })
    }
    
    // MARK: - Enroll Sucess View
    func showCustomSucessDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let exitVc = self.storyboard?.instantiateViewController(withIdentifier: "EnrollSucessView") as? EnrollSucessView
        
        
        
        // Create the dialog
        let popup = PopupDialog(viewController: exitVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        exitVc?.msg_lbl.text = "Profile updated successfully"
        exitVc?.ok_btn.addTargetClosure { _ in
            popup.dismiss()
            self.exitBtn()
        }
        present(popup, animated: animated, completion: nil)
    }
    
    func exitBtn(){
        //let obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
       // self.navigationController?.pushViewController(obj, animated: true)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = customIrregularityStyle(delegate: nil)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
    
    @IBAction func actionUpdate_btn(_ sender: Any) {
        let img = UIImage(named: "demo_icon")
        if profile_imgView.image == img {
            self.showAlert(title: "Alert", message: "Please choose profile photo!")
        }else if name_txtFld.text == ""{
            self.showAlert(title: "Alert", message: "Please enter your name!")
        }else if dateOfBirth_txtFld.text == ""{
            self.showAlert(title: "Alert", message: "Please enter date of birth name!")
        }else if dateOfBirth_txtFld.text == ""{
            self.showAlert(title: "Alert", message: "Please enter orgazination name!")
        }else{
            let token = Configurator.tokenBearer + userDefault.string(forKey: userDefualtKeys.user_Token.rawValue)!
            profileUpdateApi(device_token: token, accept: "Accept", name: name_txtFld.text!, dateOfBirth: dateOfBirth_txtFld.text!, Organization: organization_txtFld.text!, profileImg: imgToUpload)
        }
    }
    
    @IBAction func actionProfile_btn(_ sender: Any) {
        showAlert()
    }
    
    @IBAction func actionBack_btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
