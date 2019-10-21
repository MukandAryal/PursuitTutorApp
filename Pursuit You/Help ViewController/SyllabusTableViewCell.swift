//
//  SyllabusTableViewCell.swift
//  Pursuit TutorApp
//
//  Created by Apple SSD2 on 21/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class SyllabusTableViewCell: UITableViewCell {
    @IBOutlet weak var lesson_lbl: UILabel!
    @IBOutlet weak var syllabus_nameLbl: UILabel!
    @IBOutlet weak var syllabus_descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
