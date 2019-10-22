//
//  CourseProgressViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 03/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class CourseProgressViewController: BaseClassViewController {
    
    @IBOutlet weak var course_Tblview: UITableView!
    @IBOutlet weak var course_nameLbl: UILabel!
    @IBOutlet weak var course_progressTblHeightConstrains: NSLayoutConstraint!
    @IBOutlet weak var course_dateLbl: UILabel!
    @IBOutlet weak var review_lbl: UILabel!
    @IBOutlet weak var noLession_addedLbl: UILabel!
    @IBOutlet weak var completeImg_view: UIImageView!
    
    @IBOutlet weak var courseNotCompleted_heightConstraints: NSLayoutConstraint!
    var courseProgress = getAllCourse.allTutorCourse()
    var syllabusArr = [getAllCourse.syllabusInfo]()
    
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
        course_nameLbl.text = courseProgress.course_name
        noLession_addedLbl.isHidden = true
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM yyyy"
        if let date = dateFormatterGet.date(from:  courseProgress.created_at!) {
            course_dateLbl.text = dateFormatterPrint.string(from: date)
        }
        syllabusApi()
    }
    
    override func viewDidLayoutSubviews() {
        course_Tblview.frame.size = course_Tblview.contentSize
        course_progressTblHeightConstrains.constant = 520
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //  MARK: - Get All Course Api
    func syllabusApi(){
        // showCustomProgress()
        LoadingIndicatorView.show()
        let urlApi = ApiEndPoints.syllabus +  "?course_id=\(String(describing: courseProgress.course_id))" +  "&&tutor_id=\(String(describing: courseProgress.tutor_relation_id))"
        print("urlApi>",urlApi)
        WebserviceSigleton.shared.GETService(urlString: urlApi) { (response, error) in
            if error == nil{
                let resultDict = response as NSDictionary?
                LoadingIndicatorView.hide()
                if (resultDict?["success"]) != nil{
                    if let sucessDict = resultDict?["success"] as? [AnyObject]{
                        if sucessDict.count == 0 {
                            self.course_progressTblHeightConstrains.constant = 0
                            self.courseNotCompleted_heightConstraints.constant = 0
                            self.noLession_addedLbl.isHidden = false
                            self.completeImg_view.isHidden = true
                        }
                        for obj in sucessDict{
                            let course = getAllCourse.syllabusInfo(
                                id: obj["id"] as? Int,
                                course_id: obj["course_id"] as? Int,
                                title: obj["title"] as? String,
                                description: obj["description"] as? String,
                                status: obj["status"] as? String,
                                created_at: obj["created_at"] as? String,
                                updated_at: obj["created_at"] as? String)
                            self.syllabusArr.append(course)
                            self.course_Tblview.reloadData()
                        }
                    }else{
                        self.course_progressTblHeightConstrains.constant = 0
                        self.courseNotCompleted_heightConstraints.constant = 0
                        self.noLession_addedLbl.isHidden = false
                        self.completeImg_view.isHidden = true
                    }
                }else{
                    self.course_progressTblHeightConstrains.constant = 0
                    self.courseNotCompleted_heightConstraints.constant = 0
                    self.noLession_addedLbl.isHidden = false
                    self.completeImg_view.isHidden = true
                    
                }
            }else{
                self.showAlert(title: "Alert", message: "No Data Found!")
            }
            self.stopProgress()
        }
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionHelp_btn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "AddSyllabusViewController") as! AddSyllabusViewController
        obj.courseProgressDetails = courseProgress
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

extension CourseProgressViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return syllabusArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseProgressTableViewCell") as! CourseProgressTableViewCell
        cell.lession_nameLbl.text = syllabusArr[indexPath.row].title
        cell.lession_numberLbl?.text = syllabusArr[indexPath.row].course_id?.description
        return cell
    }
}

extension CourseProgressViewController : UITableViewDelegate{
    
}
