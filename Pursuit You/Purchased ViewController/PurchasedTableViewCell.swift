//
//  PurchasedTableViewCell.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 30/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class PurchasedTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
