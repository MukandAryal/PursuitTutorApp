//
//  SecondDashBroadCollectionViewCell.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 24/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class SecondDashBroadCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var appLogo_imgView: UIImageView!
    @IBOutlet weak var description_lbl: UILabel!
    @IBOutlet weak var bottom_view: UIView!
    @IBOutlet weak var skipView: UIView!
    @IBOutlet weak var next_view: UIView!
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var skip_btn: UIButton!
    @IBOutlet weak var next_btn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottom_view.layer.cornerRadius = 50
        bottom_view.clipsToBounds = true
        skipView.layer.cornerRadius = 50
        skipView.clipsToBounds = true
        next_view.layer.cornerRadius = 50
        next_view.clipsToBounds = true
        
    }
}
