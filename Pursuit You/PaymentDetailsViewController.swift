//
//  PaymentDetailsViewController.swift
//  Pursuit TutorApp
//
//  Created by Apple SSD2 on 14/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class PaymentDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionBack_Btn(_ sender: Any) {
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
