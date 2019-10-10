//
//  CourseProgressViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 03/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class CourseProgressViewController: UIViewController {
    
    @IBOutlet weak var course_Tblview: UITableView!
    
    @IBOutlet weak var course_progressTblHeightConstrains: NSLayoutConstraint!
    let section = ["lession 1", "Lession 2", "Lession 3"]
    
    let items = [["System Introdution", "System Introdution", "Assigment","Assigment"],["System Introdution", "System Introdution", "Assigment","Assigment"],["System Introdution", "System Introdution", "Assigment","Assigment"]]
    
    let sectionTitles = ["lession 1", "Lession 2", "Lession 3"]
    
    let foodItems = [["System Introdution", "System Introdution", "Assigment","Assigment"],["System Introdution", "System Introdution", "Assigment","Assigment"],["System Introdution", "System Introdution", "Assigment","Assigment"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibHeaderName = UINib(nibName: "CourseProgressHeaderView", bundle: nil)
        course_Tblview.register(nibHeaderName, forHeaderFooterViewReuseIdentifier: "CourseProgressHeaderView")
        
        let nibFooterName = UINib(nibName: "CourseProgressFooterView", bundle: nil)
        course_Tblview.register(nibFooterName, forHeaderFooterViewReuseIdentifier: "CourseProgressFooterView")
        
        course_Tblview.register(UINib(nibName: "CourseProgressTableViewCell", bundle: nil), forCellReuseIdentifier: "CourseProgressTableViewCell")
        
        course_Tblview.register(UINib(nibName: "CourseProgressTopCell", bundle: nil), forCellReuseIdentifier: "CourseProgressTopCell")
        
        course_Tblview.register(UINib(nibName: "CourseProgressBottomCell", bundle: nil), forCellReuseIdentifier: "CourseProgressBottomCell")
        course_Tblview.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        course_Tblview.frame.size = course_Tblview.contentSize
        course_progressTblHeightConstrains.constant = 520
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionHelp_btn(_ sender: Any) {
      let obj = self.storyboard?.instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

extension CourseProgressViewController : UITableViewDataSource{
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //
    //        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CourseProgressHeaderView") as! CourseProgressHeaderView
    //
    //        return headerView
    //    }
    //
    //        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CourseProgressFooterView") as! CourseProgressFooterView
    //    
    //            return footerView
    //        }
    //    
    //        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //            return 150
    //        }
    //    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        return sectionTitles[section]
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }
    
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //
    //        return self.section[section]
    //
    //    }
    
    //    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    //        return self.section.count
    //
    //    }
    
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //
    //        return self.items[section].count
    //
    //    }
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseProgressTableViewCell") as! CourseProgressTableViewCell
        //cell.lession_nameLbl.text = self.items[indexPath.section][indexPath.row]
       // cell.lession_nameLbl?.text = foodItems[indexPath.section][indexPath.row]
        
        
        return cell
    }
}

extension CourseProgressViewController : UITableViewDelegate{
    
}
