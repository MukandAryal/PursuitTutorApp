//
//  HomeViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 25/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class HomeViewController: BaseClassViewController {
    
    @IBOutlet weak var categoryTbl_view: UITableView!
    
    static var index = 0
    let cellSpacingHeight: CGFloat = 20
    var develompentArr = [String]()
    var courseArr = [getAllCourse.course]()
    
    // MARK: - App Life Cycle Method
    public override func viewDidLoad() {
        categoryTbl_view.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        self.tabBarController?.tabBar.isHidden = false
        tutorCourseApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
   //  MARK: - Get All Course Api
    func tutorCourseApi(){
        showCustomProgress()
        WebserviceSigleton.shared.GETService(urlString: ApiEndPoints.getAllCourse) { (response, error) in
            if error == nil{
                let resultDict = response as NSDictionary?
                if (resultDict?["success"]) != nil{
                    if let sucessDict = resultDict?["success"] as? NSDictionary{
                        let dataArr = sucessDict["data"] as? [AnyObject]
                        for obj in dataArr!{
                            let course = getAllCourse.course(
                                id: obj["id"] as? Int,
                                name: obj["name"] as? String,
                                des: obj["description"] as? String,
                                fee: obj["fee"] as? Int,
                                category_id: obj["category_id"] as? Int,
                                status: obj["status"] as? String,
                                created_at: obj["created_at"] as? String,
                                updated_at: obj["created_at"] as? String)
                            self.courseArr.append(course)
                            print(self.courseArr)
                            self.categoryTbl_view.reloadData()
                        }
                    }
                }
            }else{
                self.showAlert(title: "Alert", message: "server issue please try again")
            }
            self.stopProgress()
        }
    }
    
    
    // MARK: - Button Action
    @IBAction func actionNotification_btn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "NotifcationViewController") as! NotifcationViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

// MARK: - UITableView DataSource
extension HomeViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        cell.title_lbl.text = courseArr[indexPath.row].name
        cell.description_lbl.text = courseArr[indexPath.row].des
        cell.price_lbl.text = courseArr[indexPath.row].fee?.description
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd MMMM yyyy hh:mm aa"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM yyyy"
        if let date = dateFormatterGet.date(from:  courseArr[indexPath.row].created_at!) {
            cell.date_lbl.text = dateFormatterPrint.string(from: date)
        } else {
        }
        return cell
    }
}

// MARK: - UITableView Delegate
extension HomeViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailsViewController") as! CourseDetailsViewController
        obj.courseName = courseArr[indexPath.row].name!
        obj.courseDescription = courseArr[indexPath.row].des!
        obj.courseId = courseArr[indexPath.row].id!
        obj.coursePrice = "$" + " " + courseArr[indexPath.row].fee!.description
        self.navigationController?.pushViewController(obj, animated: true)
    }
}
