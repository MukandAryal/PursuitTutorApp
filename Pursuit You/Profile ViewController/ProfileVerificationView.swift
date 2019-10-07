//
//  ProfileVerificationView.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 03/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class ProfileVerificationView: UIViewController {

    @IBOutlet weak var emailVerification_titleLbl: UILabel!
    @IBOutlet weak var emailVerification_descriptionLbl: UILabel!
    @IBOutlet weak var notNot_btn: UIButton!
    @IBOutlet weak var sendOtp_btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailVerification_descriptionLbl.text = "You need to verify the email to enroll the /n course"
        emailVerification_titleLbl.text = "Email Verification"

    }
}
