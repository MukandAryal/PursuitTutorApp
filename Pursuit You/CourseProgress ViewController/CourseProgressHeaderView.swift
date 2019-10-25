//
//  CourseProgressHeaderView.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 03/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit
import Cosmos

class CourseProgressHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var course_ImgView: UIImageView!
    @IBOutlet weak var course_nameLbl: UILabel!
    
    @IBOutlet weak var duration_lbl: UILabel!
    @IBOutlet weak var courseDate_lbl: UILabel!
    @IBOutlet weak var review_starView: CosmosView!
    
    @IBOutlet weak var review_lbl: UILabel!
    
    //    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
