//
//  CourseDetailsTableViewCell.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 04/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class CourseDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var lession_noLbl: UILabel!
    @IBOutlet weak var course_reviewLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
