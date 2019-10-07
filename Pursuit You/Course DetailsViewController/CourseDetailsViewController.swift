//
//  CourseDetailsViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 04/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class CourseDetailsViewController: UIViewController {

    @IBOutlet weak var courseDetails_Tblview: UITableView!
    
    @IBOutlet weak var description_textView: UITextView!
    @IBOutlet weak var courseDetails_heightConstrains: NSLayoutConstraint!
//    let section = ["lession 1", "Lession 2", "Lession 3"]
//
//    let items = [["System Introdution", "System Introdution", "Assigment","Assigment"],["System Introdution", "System Introdution", "Assigment","Assigment"],["System Introdution", "System Introdution", "Assigment","Assigment"]]
    
    let sectionTitles = ["lession 1", "Lession 2", "Lession 3"]
    
    let foodItems = [["System Introdution", "System Introdution", "Assigment","Assigment"],["System Introdution", "System Introdution", "Assigment","Assigment"],["System Introdution", "System Introdution", "Assigment","Assigment"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseDetails_Tblview.tableFooterView = UIView()

        let nibHeaderName = UINib(nibName: "CourseProgressHeaderView", bundle: nil)
        courseDetails_Tblview.register(nibHeaderName, forHeaderFooterViewReuseIdentifier: "CourseProgressHeaderView")
        
        let nibFooterName = UINib(nibName: "CourseProgressFooterView", bundle: nil)
        courseDetails_Tblview.register(nibFooterName, forHeaderFooterViewReuseIdentifier: "CourseProgressFooterView")
        
        courseDetails_Tblview.register(UINib(nibName: "CourseDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "CourseDetailsTableViewCell")
        courseDetails_Tblview.reloadData()
        description_textView.text = "We've been working with NSLayoutConstraint and the AutoSize system to dynamically set sizes. There are not many tutorials about using this system programmatically... and definitely not much explanation with autosizing cells.I spent a few hours today and figured out the bare minimum you need to make UITableViewCell's dynamically set their height based on a UILabel's content.If you search online, you'll likely encounter this Stackoverflow article that discusses the topic in detail. The corresponding code example for iOS7 is extremely heavy weight. I took what was done there, reverse engineered it, and pared it back to the core library. You can get this functionality with a few lines of code. Yay!"
         //self.courseDetails_heightConstrains.constant = 30*4+30
       // viewHeight_constraints.constant = 500
        
    }
    
    override func viewDidLayoutSubviews() {
        courseDetails_Tblview.frame.size = courseDetails_Tblview.contentSize
        courseDetails_heightConstrains.constant = 300
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        adjustUITextViewHeight(arg: description_textView)
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CourseDetailsViewController : UITableViewDataSource{
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //
    //        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CourseProgressHeaderView") as! CourseProgressHeaderView
    //
    //        return headerView
    //    }
    //
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CourseProgressFooterView") as! CourseProgressFooterView
//        
//        return footerView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 150
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseDetailsTableViewCell") as! CourseDetailsTableViewCell
        //cell.lession_nameLbl.text = self.items[indexPath.section][indexPath.row]
      //  cell.lession_nameLbl?.text = foodItems[indexPath.section][indexPath.row]

        
        return cell
    }
}

extension CourseDetailsViewController : UITableViewDelegate{
    
}
