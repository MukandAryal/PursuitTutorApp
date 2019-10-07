//
//  MyCourseViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 27/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class MyCourseViewController: UIViewController {
    @IBOutlet weak var myCourse_tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    myCourse_tblView.register(UINib(nibName: "MyCoursesTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCoursesTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func action_notification(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "NotifcationViewController") as! NotifcationViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

extension MyCourseViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCoursesTableViewCell") as! MyCoursesTableViewCell
        
        return cell
    }
}

extension MyCourseViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let obj = self.storyboard?.instantiateViewController(withIdentifier: "CourseProgressViewController") as! CourseProgressViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
}
