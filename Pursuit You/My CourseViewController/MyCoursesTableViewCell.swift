//
//  MyCoursesTableViewCell.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 27/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class MyCoursesTableViewCell: UITableViewCell {
    @IBOutlet weak var course_Img: UIImageView!
    @IBOutlet weak var course_title: UILabel!
    @IBOutlet weak var courseComplete_progressBar: UIProgressView!
    @IBOutlet weak var courseStart_DateLbl: UILabel!
    @IBOutlet weak var courseComplete_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let screenSize = UIScreen.main.bounds
        let separatorHeight = CGFloat(5.0)
        let additionalSeparator = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height-separatorHeight, width: screenSize.width, height: separatorHeight))
        additionalSeparator.backgroundColor = UIColor(red: 238/254, green: 239/254, blue: 234/254, alpha: 1.0)
        self.addSubview(additionalSeparator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
       // contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
