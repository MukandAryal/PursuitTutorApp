//
//  BatchCreationViewController.swift
//  Pursuit TutorApp
//
//  Created by Apple SSD2 on 10/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class BatchCreationViewController: UIViewController,UITextFieldDelegate {
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
            selectStartDate_txfFld.text = dateFormatter.string(from: datePicker.date)
        }
        if selectEndDate_txtFld.isFirstResponder {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            selectEndDate_txtFld.text = dateFormatter.string(from: datePicker.date)
        }
        if selectStartTime_txtFld.isFirstResponder {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            selectStartTime_txtFld.text = formatter.string(from: timePicker.date)
        }
        if selectEndTime_txtFld.isFirstResponder {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            selectEndTime_txtFld.text = formatter.string(from: timePicker.date)
        }
        self.view.endEditing(true)
    }

    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


