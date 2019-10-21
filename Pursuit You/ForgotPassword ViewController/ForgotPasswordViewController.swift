//
//  ForgotPasswordViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 04/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: BaseClassViewController {
    @IBOutlet weak var email_txtFld: UITextField!
    
      // MARK: - App Life Cyle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Start for enroll Api
    func forgotPassword(){
        //showCustomProgress()
        LoadingIndicatorView.show()
        let param: [String: String] = [
            "email" : email_txtFld.text!
        ]
        WebserviceSigleton.shared.POSTServiceWithParameters(urlString: ApiEndPoints.forgotPassword, params: param as Dictionary<String, AnyObject>) { (response, error) in
            LoadingIndicatorView.hide()
            //self.stopProgress()
            let resultDict = response as NSDictionary?
            print("resultDict>>>>>>>>",resultDict)
            //  if let errorDict = resultDict?["error"] as? NSDictionary{
            //  print(errorDict)
            //  }else{
            //self.showCustomSucessDialog()
            self.showAlert(title: "Alert", message: (resultDict!["message"] as? String)!)
            // }
            //self.stopProgress()
        }
    }
    
    // MARK: - Button Action
    @IBAction func actionBack_btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionsendOtp_btn(_ sender: Any) {
        if email_txtFld.text == ""{
            showAlert(title: "Alert", message: "Please enter email id!")
        }else if !isValidEmail(testStr: email_txtFld.text!){
            showAlert(title: "Alert", message: "Please enter valid email id!")
        }else{
             if Connectivity.isConnectedToInternet() {
                forgotPassword()
             }else{
               self.showAlert(title: "No Internet!", message: "Please check your internet connection")
            }
        }
        
    }
}
