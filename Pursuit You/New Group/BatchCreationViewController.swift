//
//  BatchCreationViewController.swift
//  Pursuit TutorApp
//
//  Created by Apple SSD2 on 10/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class BatchCreationViewController: BaseClassViewController,UITextFieldDelegate {
    @IBOutlet weak var selectStartDate_txfFld: UITextField!
    @IBOutlet weak var selectEndDate_txtFld: UITextField!
    @IBOutlet weak var selectStartTime_txtFld: UITextField!
    @IBOutlet weak var selectEndTime_txtFld: UITextField!
    
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    let timePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectStartDate_txfFld.delegate = self
        selectStartDate_txfFld.delegate  = self
        selectStartTime_txtFld.delegate = self
        selectEndTime_txtFld.delegate  = self
        selectStartDate_txfFld.inputView    = datePicker
        selectEndDate_txtFld.inputView      = datePicker
        timePicker.datePickerMode = .time
        selectStartTime_txtFld.inputView = timePicker
        selectEndTime_txtFld.inputView = timePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        selectStartDate_txfFld.inputAccessoryView   = toolbar
        selectEndDate_txtFld.inputAccessoryView     = toolbar
        selectStartTime_txtFld.inputAccessoryView = toolbar
        selectEndTime_txtFld.inputAccessoryView = toolbar
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == selectStartDate_txfFld {
            datePicker.datePickerMode = .date
        }
        if textField == selectEndDate_txtFld {
            datePicker.datePickerMode = .date
        }
        if textField == selectStartTime_txtFld {
            timePicker.datePickerMode = .time
        }
        if textField == selectEndTime_txtFld {
            timePicker.datePickerMode = .time
        }
    }
    
    @objc func doneButtonTapped() {
        if selectStartDate_txfFld.isFirstResponder {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "yyyy-MM-dd"
            selectStartDate_txfFld.text = dateFormatter.string(from: datePicker.date)
        }
        if selectEndDate_txtFld.isFirstResponder {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "yyyy-MM-dd"
            selectEndDate_txtFld.text = dateFormatter.string(from: datePicker.date)
        }
        if selectStartTime_txtFld.isFirstResponder {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateFormat = "HH:mm"
            selectStartTime_txtFld.text = formatter.string(from: timePicker.date)
        }
        if selectEndTime_txtFld.isFirstResponder {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateFormat = "HH:mm"
            selectEndTime_txtFld.text = formatter.string(from: timePicker.date)
        }
        self.view.endEditing(true)
    }
    
    // MARK: - Login Validation
    func isValiadCreatBatch(){
        if selectStartDate_txfFld.text! == ""{
            self.showAlert(title: "Alert", message: "Please enter start date of course!")
        }else if selectEndDate_txtFld.text! == "" {
            self.showAlert(title: "Alert", message: "Please enter end date of course!")
        }else if selectEndDate_txtFld.text! == "" {
            self.showAlert(title: "Alert", message: "Please enter start time!")
        }else if selectEndDate_txtFld.text! == "" {
            self.showAlert(title: "Alert", message: "Please enter end time!")
        }else{
            if Connectivity.isConnectedToInternet() {
                createBatchApi()
            } else {
                showAlert(title: "No Internet!", message: "Please check your internet connection")
            }
        }
    }
    
    // MARK: - Login Api Implement
    func createBatchApi(){
        //  showCustomProgress()
        // indicator.startAnimating()
        print(selectStartTime_txtFld.text!)
        let startTime = selectStartTime_txtFld.text?.dropLast(3) ?? ""+":00"
        let startTimeStr = startTime + ":00"
        let endTime = selectEndTime_txtFld.text?.dropLast(3) ?? ""+":00"
        let endTimeStr = endTime + ":00"
        print("startTimeStr>>>>>>>",startTimeStr)
        print("endTimeStr>>>>>>",endTimeStr)
        let startDate = selectStartDate_txfFld.text
        let endDate = selectEndDate_txtFld.text
        print("startDate>>>>>>",startTimeStr)
        print("startDate>>>>>>",endTimeStr)
        print("startDate>>>>>>",startDate)
        print("startDate>>>>>>",endDate)

        LoadingIndicatorView.show()
        let param: [String: String] = [
            "start_date" : String(startDate ?? ""),
            "end_date" : String(endDate ?? ""),
            "class_start_time" : String(startTimeStr ),
            "class_end_time" : String(endTimeStr ),
            "relation_tutor_id" : "42",
            "title" : "Test Class",
            "description" : "description"
        ]
        print("param>>>>>",param)
        WebserviceSigleton.shared.POSTServiceWithParameters(urlString: ApiEndPoints.createBatch, params: param as Dictionary<String, AnyObject>) { (response, error) in
            LoadingIndicatorView.hide()
            let resultDict = response as NSDictionary?
            if let error = resultDict?.object(forKey: "error") as? String{//error
                self.showAlert(title: "Alert", message: error)
            }else { //sucess
                let successStr = resultDict?["success"] as! String
                print(successStr)
                self.showCustomSucessDialog()
            }
            //  self.stopProgress()
            //self.indicator.stopAnimating()
            
        }
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
        
        exitVc?.msg_lbl.text = "Class added successfully"
        exitVc?.ok_btn.addTargetClosure { _ in
            popup.dismiss()
            self.exitBtn()
        }
        present(popup, animated: animated, completion: nil)
    }
    
    func exitBtn(){
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func actionSubmit_btn(_ sender: Any) {
        isValiadCreatBatch()
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


