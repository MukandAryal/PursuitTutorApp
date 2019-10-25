//
//  CourseProgressTableViewCell.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 03/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class CourseProgressTableViewCell: UITableViewCell {

    @IBOutlet weak var complete_syllabusBtn: UIButton!
    @IBOutlet weak var lession_numberLbl: UILabel!
    @IBOutlet weak var lession_nameLbl: UILabel!
    @IBOutlet weak var lession_readIcon: UIImageView!
    @IBOutlet weak var lession_descriptionLbl: UILabel!
    @IBOutlet weak var syllabusLine_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
