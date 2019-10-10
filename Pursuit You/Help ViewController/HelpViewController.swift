//
//  HelpViewController.swift
//  Pursuit TutorApp
//
//  Created by Apple SSD2 on 10/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionback_btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
