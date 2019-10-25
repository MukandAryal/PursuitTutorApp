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
    @IBOutlet weak var noLession_addedLbl: UILabel!
    
    var courseProgress = getAllCourse.allTutorCourse()
    var courseProgressDeatils = getAllCourse.course()
    var syllabusArr = [getAllCourse.syllabusInfo]()
    
    
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
        syllabusApi()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //  MARK: - Get All Course Api
    func syllabusApi(){
        LoadingIndicatorView.show()
        let urlApi = ApiEndPoints.syllabus +  "?course_id=\(courseProgress.course_id!))" +  "&tutor_id=\(courseProgress.user_id!))"
        print("urlApi>",urlApi)
        WebserviceSigleton.shared.GETService(urlString: urlApi) { (response, error) in
            if error == nil{
                let resultDict = response as NSDictionary?
                LoadingIndicatorView.hide()
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
                            self.course_Tblview.reloadData()
                            print(self.syllabusArr.count)
                        }
                    }else{
                    }
                }else{
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
        print("courseProgressDeatils>>>>",courseProgressDeatils)
        obj.courseProgressDetails = courseProgress
        obj.courseName = courseProgress.course_name!
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

extension CourseProgressViewController : UITableViewDataSource{
    
    private func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = self.course_Tblview.dequeueReusableHeaderFooterView(withIdentifier: "CourseProgressFooterView" ) as! CourseProgressFooterView
        if syllabusArr.count == 0{
           // footerView.syllabus_imgView.isHidden = true
            footerView.syllabusStaus_lbl.text = "No Syllabus Found"
           //footerView.courseStatusImg_leadingContraints.constant = 80
        }else{
           // footerView.syllabus_imgView.isHidden = false
            footerView.syllabusStaus_lbl.text = "Not Completed"
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 315
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let headerView = self.course_Tblview.dequeueReusableHeaderFooterView(withIdentifier: "CourseProgressHeaderView" ) as! CourseProgressHeaderView
        headerView.course_nameLbl.text = courseProgress.course_name
        if let imgProfile = courseProgress.imageProfile{
            let imageStr = Configurator.courseImageBaseUrl + imgProfile
            headerView.course_ImgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "development"))
        }
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yyyy"
        if let dateStr = courseProgress.created_at{
        if let date = dateFormatterGet.date(from:  dateStr) {
            headerView.courseDate_lbl.text = dateFormatterPrint.string(from: date)
         }
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
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
        cell.lession_descriptionLbl.text = syllabusArr[indexPath.row].description
        cell.lession_numberLbl.text = ("\(indexPath.row+1)")

        if indexPath.row == self.syllabusArr.count - 1  {
            cell.syllabusLine_lbl.isHidden = true
        }
        return cell
    }
}

extension CourseProgressViewController : UITableViewDelegate{
    
}
