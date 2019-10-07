//
//  LoginViewViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 24/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class LoginViewViewController: BaseClassViewController {
    @IBOutlet weak var appLogo_imgView: UIImageView!
    @IBOutlet weak var bottom_view: UIView!
    @IBOutlet weak var loginLine_indicatior: UILabel!
    @IBOutlet weak var singUpLine_indicator: UILabel!
    @IBOutlet weak var emailAddress_view: UIView!
    @IBOutlet weak var password_view: UIView!
    @IBOutlet weak var signUp_btn: UIButton!
    @IBOutlet weak var emailAddress_txtFld: UITextField!
    @IBOutlet weak var password_txtFld: UITextField!
    @IBOutlet weak var login_view: UIView!
    @IBOutlet weak var singUp_view: UIView!
    @IBOutlet weak var fullName_view: UIView!
    @IBOutlet weak var singUpemailAddress_view: UIView!
    @IBOutlet weak var singUpPassword_view: UIView!
    @IBOutlet weak var singUpConfirmPassword_view: UIView!
    @IBOutlet weak var singUpSingIn_btn: UIButton!
    @IBOutlet weak var signUpFullName_txtFld: UITextField!
    @IBOutlet weak var signUpEmailAddress_txtFld: UITextField!
    @IBOutlet weak var signUpPassword_txtFld: UITextField!
    @IBOutlet weak var signUpConfirmPassword_txtFld: UITextField!
    var window: UIWindow?
    
    
    // MARK: - App Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpUiInterFace()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Set Up UIInterFace
    func SetUpUiInterFace(){
         //login view UiInterface
        emailAddress_txtFld.text = "tutor@mail.com"
        password_txtFld.text = "1234"
        appLogo_imgView.layer.cornerRadius = appLogo_imgView.frame.height/2
        appLogo_imgView.clipsToBounds = true
        // singIn view UiInterface
        singUpLine_indicator.backgroundColor = UIColor.white
        singUp_view.isHidden = true
        self.view.backgroundColor = appThemeColor
    }
    
    // MARK: - Login Validation
    func isValiadLogin(){
        if emailAddress_txtFld.text! == ""{
             showAlert(title: "Alert", message: "Please Enter Email Id!")
        }else if !isValidEmail(testStr: emailAddress_txtFld.text!) {
            showAlert(title: "Alert", message: "Please Enter Valid Email Id!")
        }else if password_txtFld.text! == "" {
            showAlert(title: "Alert", message: "Please Enter Password!")
        }else{
            if Connectivity.isConnectedToInternet() {
                loginApi()
            } else {
                showAlert(title: "No Internet!", message: "Please check your internet connection")
            }
        }
    }
    
    // MARK: - SignUp Validation
    func isValiadSignUp(){
        if signUpFullName_txtFld.text! == ""{
            showAlert(title: "Alert", message: "Please Enter Full Name!")
        }else if signUpEmailAddress_txtFld.text! == "" {
             showAlert(title: "Alert", message: "Please Enter Email Id!")
        }else if !isValidEmail(testStr: signUpEmailAddress_txtFld.text!) {
            showAlert(title: "Alert", message: "Please Enter Valid Email Id!")
        }else if signUpPassword_txtFld.text! == ""{
            showAlert(title: "Alert", message: "Please Enter Password!")
        }else if signUpConfirmPassword_txtFld.text! == ""{
             showAlert(title: "Alert", message: "Please Enter Confirm Password!")
        }else if signUpPassword_txtFld.text! != signUpConfirmPassword_txtFld.text!{
            showAlert(title: "Alert", message: "Password Does Not Match!")
        }else{
            if Connectivity.isConnectedToInternet() {
                signUpApi()
            } else {
                showAlert(title: "No Internet!", message: "Please check your internet connection")
            }
        }
    }
    
    // MARK: - Login Api Implement
    func loginApi(){
        showCustomProgress()
        let param: [String: String] = [
            "email" : emailAddress_txtFld.text!,
            "password" : password_txtFld.text!,
            "type" : "1"
        ]
        WebserviceSigleton.shared.POSTServiceWithParameters(urlString: ApiEndPoints.login, params: param as Dictionary<String, AnyObject>) { (response, error) in
            let resultDict = response as NSDictionary?
            if let error = resultDict?.object(forKey: "error") as? String{//error
                self.showAlert(title: "Alert", message: error)
            }else { //sucess
                let successDict = resultDict!["success"] as! NSDictionary
                if let token = successDict["token"] as? String{
                    print("token>>>..",token)
                    userDefault.set(token, forKey: userDefualtKeys.user_Token.rawValue)
                }
                UserDefaults.standard.set(self.emailAddress_txtFld.text, forKey: "loginPhoneNumber")
                UserDefaults.standard.set(self.password_txtFld.text, forKey: "loginPasswordNumber")
                self.window = UIWindow(frame: UIScreen.main.bounds)
                let tabBarController = customIrregularityStyle(delegate: nil)
                self.window?.rootViewController = tabBarController
                self.window?.makeKeyAndVisible()
            }
            self.stopProgress()
        }
    }
    
    // MARK: - signUp Api Implement
    func signUpApi(){
        showCustomProgress()
        let param: [String: String] = [
            "name" : signUpFullName_txtFld.text!,
            "email" : signUpEmailAddress_txtFld.text!,
            "password" : signUpPassword_txtFld.text!,
            "c_password" : signUpConfirmPassword_txtFld.text!,
            "type" : "1"
        ]
        WebserviceSigleton.shared.POSTServiceWithParameters(urlString: ApiEndPoints.register, params: param as Dictionary<String, AnyObject>) { (response, error) in
            let resultDict = response as NSDictionary?
            if let errorDict = resultDict!["error"] as? NSDictionary { //error
               print("errorDict>>>>",errorDict)
                    self.showAlert(title: "Alert", message: "Email is already in use")
            }else{
              let obj = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewViewController") as! LoginViewViewController
             self.navigationController?.pushViewController(obj, animated: true)
            }
            self.stopProgress()
        }
    }
    
    // MARK: - Buttion Action
    @IBAction func actionLogin_btn(_ sender: Any) {
        loginLine_indicatior.backgroundColor = appThemeColor
        singUpLine_indicator.backgroundColor = UIColor.white
        singUp_view.isHidden = true
        login_view.isHidden = false
    }
    
    @IBAction func actionSingUp_btn(_ sender: Any) {
        loginLine_indicatior.backgroundColor = UIColor.white
        singUpLine_indicator.backgroundColor = appThemeColor
        login_view.isHidden = true
        singUp_view.isHidden = false
    }
    
    
    @IBAction func signIn_btn(_ sender: Any) {
        isValiadLogin()
    }
    
    @IBAction func actionSignUpUser_btn(_ sender: Any) {
        isValiadSignUp()
    }
    
    @IBAction func actionForgotPassword_btn(_ sender: Any) {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}
