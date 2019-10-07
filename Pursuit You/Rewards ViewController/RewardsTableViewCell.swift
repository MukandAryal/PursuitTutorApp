//
//  RewardsTableViewCell.swift
//  Pursuit TutorApp
//
//  Created by Apple SSD2 on 07/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class RewardsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let screenSize = UIScreen.main.bounds
        let separatorHeight = CGFloat(5.0)
        let additionalSeparator = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height-separatorHeight, width: screenSize.width, height: separatorHeight))
        additionalSeparator.backgroundColor = UIColor(red: 238/254, green: 239/254, blue: 234/254, alpha: 1.0)
        self.addSubview(additionalSeparator)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
