//
//  MyCourseViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 27/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class MyCourseViewController: BaseClassViewController {
    @IBOutlet weak var myCourse_tblView: UITableView!
    var tutorCourseArr = [getAllCourse.allTutorCourse]()
    
    // MARK: - App Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        if Connectivity.isConnectedToInternet() {
            //tutorCourseArr.removeAll()
            allCourseApi()
        } else {
            showAlert(title: "No Internet!", message: "Please check your internet connection")
        }
        myCourse_tblView.register(UINib(nibName: "MyCoursesTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCoursesTableViewCell")
        myCourse_tblView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
       
    }
    
    // MARK: - Get All Course Api
    func allCourseApi(){
       // showCustomProgress()
        LoadingIndicatorView.show()
        WebserviceSigleton.shared.GETService(urlString: ApiEndPoints.tutorCourses) { (response, error) in
            LoadingIndicatorView.hide()
            print(response)
            if error == nil{
                let resultDict = response as NSDictionary?
                if (resultDict?["success"]) != nil{
                    if let sucessDict = resultDict?["success"] as? NSDictionary{
                        let dataArr = sucessDict["data"] as? [AnyObject]
                        for obj in dataArr!{
                            let course = getAllCourse.allTutorCourse(
                                course_id: obj["course_id"] as? Int,
                                course_name: obj["course_name"] as? String)
                            self.tutorCourseArr.append(course)
                            self.myCourse_tblView.reloadData()
                        }
                    }
                }
            }else{
                self.showAlert(title: "Alert", message: "No Data Found!")
            }
            self.stopProgress()
        }
    }
    
    // MARK: - Button Action
    @IBAction func action_notification(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "NotifcationViewController") as! NotifcationViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

// MARK: - UITableView DataSource
extension MyCourseViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutorCourseArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCoursesTableViewCell") as! MyCoursesTableViewCell
        cell.course_title.text = tutorCourseArr[indexPath.row].course_name
        return cell
    }
}

// MARK: - UITableView Delegate
extension MyCourseViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "CourseProgressViewController") as! CourseProgressViewController
        obj.courseProgress = tutorCourseArr[indexPath.row]
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
}
