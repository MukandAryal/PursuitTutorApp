//
//  CourseDetailsViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 04/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class CourseDetailsViewController: BaseClassViewController {

    @IBOutlet weak var courseDetails_Tblview: UITableView!
    @IBOutlet weak var description_textView: UITextView!
    @IBOutlet weak var courseDetails_heightConstrains:
    NSLayoutConstraint!
    @IBOutlet weak var title_course: UILabel!
    @IBOutlet weak var priceEnroll_lbl: UILabel!
    @IBOutlet weak var durationWeek_lbl: UILabel!
    @IBOutlet weak var endDate_lbl: UILabel!
    
    let sectionTitles = ["lession 1", "Lession 2", "Lession 3"]
    let foodItems = [["System Introdution", "System Introdution", "Assigment","Assigment"],["System Introdution", "System Introdution", "Assigment","Assigment"],["System Introdution", "System Introdution", "Assigment","Assigment"]]
    var courseName = String()
    var courseDescription = String()
    var courseId = Int()
    var coursePrice = String()
    var syllabusArr = [getAllCourse.syllabusInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseDetails_Tblview.tableFooterView = UIView()

        let nibHeaderName = UINib(nibName: "CourseProgressHeaderView", bundle: nil)
        courseDetails_Tblview.register(nibHeaderName, forHeaderFooterViewReuseIdentifier: "CourseProgressHeaderView")
        
        let nibFooterName = UINib(nibName: "CourseProgressFooterView", bundle: nil)
        courseDetails_Tblview.register(nibFooterName, forHeaderFooterViewReuseIdentifier: "CourseProgressFooterView")
        
        courseDetails_Tblview.register(UINib(nibName: "CourseDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "CourseDetailsTableViewCell")
        courseDetails_Tblview.reloadData()
        description_textView.text = courseDescription
        title_course.text = courseName
        priceEnroll_lbl.text = coursePrice
        syllabusApi()
    }
    
    override func viewDidLayoutSubviews() {
       // courseDetails_Tblview.frame.size = courseDetails_Tblview.contentSize
        courseDetails_heightConstrains.constant = CGFloat(syllabusArr.count*100)
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
    
    //  MARK: - Get All Course Api
    func syllabusApi(){
        showCustomProgress()
        let urlApi = ApiEndPoints.syllabus +  "?course_id=\(courseId)"
        print("urlApi>",urlApi)
        WebserviceSigleton.shared.GETService(urlString: urlApi) { (response, error) in
            if error == nil{
                let resultDict = response as NSDictionary?
                if (resultDict?["success"]) != nil{
                    if let sucessDict = resultDict?["success"] as? [AnyObject]{
                        if sucessDict.count == 0 {
                            
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
                            print(self.syllabusArr)
                            self.courseDetails_Tblview.reloadData()
                            self.courseDetails_heightConstrains.constant = CGFloat(self.syllabusArr.count*100)
                        }
                    }
                }
            }else{
                self.showAlert(title: "Alert", message: "server issue please try again")
            }
            self.stopProgress()
        }
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CourseDetailsViewController : UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return syllabusArr.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseDetailsTableViewCell") as! CourseDetailsTableViewCell
        cell.lession_noLbl.text = "Lesson" + " " + syllabusArr[indexPath.row].id!.description
        cell.course_reviewLbl.text = syllabusArr[indexPath.row].title
        return cell
    }
}

extension CourseDetailsViewController : UITableViewDelegate{
    
}
