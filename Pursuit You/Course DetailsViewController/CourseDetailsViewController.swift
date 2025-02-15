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
    @IBOutlet weak var startEnroll_btn: UIButton!
    @IBOutlet weak var courseDetails_imgView: UIImageView!
    
    let sectionTitles = ["lession 1", "Lession 2", "Lession 3"]
    let foodItems = [["System Introdution", "System Introdution", "Assigment","Assigment"],["System Introdution", "System Introdution", "Assigment","Assigment"],["System Introdution", "System Introdution", "Assigment","Assigment"]]
    var courseName = String()
    var courseDescription = String()
    var courseId = Int()
    var coursePrice = String()
    var enrollId = Int()
    var syllabusArr = [getAllCourse.syllabusInfo]()
    var courseDetails = getAllCourse.course()
    var courseProgress = getAllCourse.allTutorCourse()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseDetails_Tblview.tableFooterView = UIView()
        
        let nibHeaderName = UINib(nibName: "CourseProgressHeaderView", bundle: nil)
        courseDetails_Tblview.register(nibHeaderName, forHeaderFooterViewReuseIdentifier: "CourseProgressHeaderView")
        
        let nibFooterName = UINib(nibName: "CourseProgressFooterView", bundle: nil)
        courseDetails_Tblview.register(nibFooterName, forHeaderFooterViewReuseIdentifier: "CourseProgressFooterView")
        
        courseDetails_Tblview.register(UINib(nibName: "CourseDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "CourseDetailsTableViewCell")
        courseDetails_Tblview.reloadData()
        title_course.text = courseDetails.name
        description_textView.text = courseDetails.des
        priceEnroll_lbl.text = "$" + " " + courseDetails.fee!
        let imageStr = Configurator.courseImageBaseUrl + courseDetails.imageProfile!
        courseDetails_imgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "development"))
        self.startEnroll_btn.setTitle("Start For Tutoring",for: .normal)
        self.startEnroll_btn.addTarget(self, action: #selector(self.startForTutringAction), for: .touchUpInside)
        //courseId = 8
    }
    
    override func viewDidLayoutSubviews() {
        courseDetails_heightConstrains.constant = CGFloat(syllabusArr.count*100)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Connectivity.isConnectedToInternet() {
            syllabusArr.removeAll()
            allCourseApi()
            syllabusApi()
        } else {
            showAlert(title: "No Internet!", message: "Please check your internet connection")
        }
        
        self.navigationController?.isNavigationBarHidden = true
        adjustUITextViewHeight(arg: description_textView)
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    // MARK: - Get All Course Api
    func allCourseApi(){
        LoadingIndicatorView.show()
        WebserviceSigleton.shared.GETService(urlString: ApiEndPoints.tutorCourses) { (response, error) in
            LoadingIndicatorView.hide()
            if error == nil{
                let resultDict = response as NSDictionary?
                if (resultDict?["success"]) != nil{
                    if let sucessDict = resultDict?["success"] as? NSDictionary{
                        let dataArr = sucessDict["data"] as? [AnyObject]
                        for obj in dataArr!{
                            let course = getAllCourse.allTutorCourse(
                                course_id: obj["course_id"] as? Int,
                                course_name: obj["course_name"] as? String,
                                created_at: obj["created_at"] as? String,
                                id: obj["id"] as? Int,
                                status: obj["status"] as? String,
                                tutorName: obj["tutorName"] as? String,
                                tutor_relation_id: obj["tutor_relation_id"] as? Int,
                                updated_at: obj["updated_at"] as? String,
                                user_id: obj["user_id"] as? Int,
                                imageProfile: obj["imageProfile"] as? String)
                            if obj["course_id"] as? Int == self.courseDetails.id{
                                print("already enroll>>>>>>>>>")
                                self.courseProgress.course_id = obj["course_id"] as? Int
                                self.courseProgress.course_name = obj["course_name"] as? String
                                self.courseProgress.created_at = obj["created_at"] as? String
                                self.courseProgress.id = obj["id"] as? Int
                                self.courseProgress.status = obj["status"] as? String
                                self.courseProgress.tutor_relation_id = obj["tutor_relation_id"] as? Int
                                self.courseProgress.tutorName = obj["tutorName"] as? String
                                self.courseProgress.updated_at = obj["updated_at"] as? String
                                self.courseProgress.user_id = obj["user_id"] as? Int
                                 self.courseProgress.imageProfile = obj["imageProfile"] as? String
                                self.startEnroll_btn.removeTarget(nil, action: nil, for: .allEvents)
                                self.startEnroll_btn.setTitle("Already Enrolled",for: .normal)
                                self.startEnroll_btn.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
                            }
                        }
                    }
                }
            }else{
                self.showAlert(title: "Alert", message: "server issue please try again")
            }
            LoadingIndicatorView.hide()
        }
    }
    
    //  MARK: - Get All Course Api
    func syllabusApi(){
        LoadingIndicatorView.show()
        let urlApi = ApiEndPoints.syllabus +  "?course_id=\(8)"
        print("urlApi>",urlApi)
        WebserviceSigleton.shared.GETService(urlString: urlApi) { (response, error) in
            LoadingIndicatorView.hide()
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
                                tutor_id: obj["tutor_id"] as? Int,
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
    
    // MARK: - Start for enroll Api
    func tutorEnrollApi(){
        LoadingIndicatorView.show()
        let param: [String: String] = [
            "course_id" : "\(courseDetails.id!)",
        ]
        WebserviceSigleton.shared.POSTServiceWithParameters(urlString: ApiEndPoints.addCourseToTutor, params: param as Dictionary<String, AnyObject>) { (response, error) in
            LoadingIndicatorView.hide()
            let resultDict = response as NSDictionary?
            if let errorDict = resultDict?["error"] as? NSDictionary{
                print(errorDict)
                self.showCustomErrorDialog()
            }else{
                if let dataDict = resultDict!["data"] as? NSDictionary{
                    if let courseId = dataDict.object(forKey: "id")as? Int{
                        self.enrollId = courseId
                        self.showCustomSucessDialog()
                    }
                }
            }
            LoadingIndicatorView.hide()
        }
    }
    
    
    // MARK: - Enroll Sucess View
    func showCustomSucessDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let exitVc = self.storyboard?.instantiateViewController(withIdentifier: "EnrollSucessView") as? EnrollSucessView
        
        
        
        // Create the dialog
        let popup = PopupDialog(viewController: exitVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        exitVc?.msg_lbl.text = "Course Enrolled Successfully"
        exitVc?.ok_btn.addTargetClosure { _ in
            popup.dismiss()
            self.doneBtn()
        }
        present(popup, animated: animated, completion: nil)
    }
    
    func doneBtn(){
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "BatchCreationViewController") as! BatchCreationViewController
        print("courseProgress>>>",courseProgress)
        obj.courseProgressDetails = courseProgress
         print("courseProgress>>>",obj.courseProgressDetails)
        obj.course_id = enrollId
        obj.courseName = courseName
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    // MARK: - Enroll Sucess View
    func showCustomErrorDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let exitVc = self.storyboard?.instantiateViewController(withIdentifier: "EnrollSucessView") as? EnrollSucessView
        
        
        
        // Create the dialog
        let popup = PopupDialog(viewController: exitVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        exitVc?.msg_lbl.text = "You Already Enrolled the course"
        let yourImage: UIImage = UIImage(named: "alert.png")!
        exitVc?.suceess_imgView.image = yourImage
        exitVc?.ok_btn.addTargetClosure { _ in
            popup.dismiss()
            //self.exitBtn()
        }
        present(popup, animated: animated, completion: nil)
    }
    
    // MARK: - Button Action
    @IBAction func actionStartForTutoring_btn(_ sender: Any) {
        //  tutorEnrollApi()
    }
    
    @objc func buttonAction(sender: UIButton!) {
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "CourseProgressViewController") as! CourseProgressViewController
                print("courseProgress>>>>>>>>>",courseProgress)
                obj.courseProgress = courseProgress
                self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @objc func startForTutringAction(sender: UIButton!) {
        tutorEnrollApi()
    }
    
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionHelp_btn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
        self.navigationController?.pushViewController(obj, animated: true)
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
