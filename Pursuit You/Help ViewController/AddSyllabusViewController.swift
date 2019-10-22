//
//  AddSyllabusViewController.swift
//  Pursuit TutorApp
//
//  Created by Apple SSD2 on 21/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class AddSyllabusViewController: BaseClassViewController {
    
    @IBOutlet weak var syllabusTbl_view: UITableView!
    @IBOutlet weak var tblView_heightConstraints: NSLayoutConstraint!
    @IBOutlet weak var lession_lbl: UILabel!
    @IBOutlet weak var title_txtFld: UITextField!
    @IBOutlet weak var description_txtFld: UITextView!
    var syllabusArr = [getAllCourse.syllabusInfo]()
    var courseProgressDetails = getAllCourse.allTutorCourse()
    var titleStr = String()
    var descriptionStr = String()
  //  var addlessionArr = [String]()
    var addlessionArr = [NSDictionary]()

    var emptyDictionary = [String:String]()
    
    var dict : [NSDictionary] = []
    var finalDict : [String:Any] = [:]


    override func viewDidLoad() {
        super.viewDidLoad()
        syllabusTbl_view.register(UINib(nibName: "SyllabusTableViewCell", bundle: nil), forCellReuseIdentifier: "SyllabusTableViewCell")
        syllabusTbl_view.tableFooterView = UIView()
        if Connectivity.isConnectedToInternet() {
            syllabusApi()
        } else {
            showAlert(title: "No Internet!", message: "Please check your internet connection")
        }
        
    }
    
    //  MARK: - Get All Course Api
    func syllabusApi(){
        // showCustomProgress()
        LoadingIndicatorView.show()
        let urlApi = ApiEndPoints.syllabus +  "?course_id=\(String(describing: courseProgressDetails.course_id))" +  "&&tutor_id=\(String(describing: courseProgressDetails.tutor_relation_id))"
        print("urlApi>",urlApi)
        WebserviceSigleton.shared.GETService(urlString: urlApi) { (response, error) in
            if error == nil{
                let resultDict = response as NSDictionary?
                LoadingIndicatorView.hide()
                if (resultDict?["success"]) != nil{
                    if let sucessDict = resultDict?["success"] as? [AnyObject]{
                        if sucessDict.count == 0 {
                            self.tblView_heightConstraints.constant = 0
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
                            self.syllabusTbl_view.reloadData()
                            // self.tblView_heightConstraints.constant = CGFloat(self.syllabusArr.count*85)
                        }
                    }else{
                        self.tblView_heightConstraints.constant = 0
                        self.lession_lbl.isHidden = true
                    }
                }else{
                    self.tblView_heightConstraints.constant = 0
                    self.lession_lbl.isHidden = true
                }
            }else{
                self.showAlert(title: "Alert", message: "No Data Found!")
            }
            self.stopProgress()
        }
    }
    // MARK: - Add Syllabus Implement
    func addSyllabusApi(){
//        LoadingIndicatorView.show()
//     //   let param: [NSDictionary] = [
//          //  "data" : JSONDecoder
//       // ]
//        print("param>>>>>",param)
//       // WebserviceSigleton.shared.POSTServiceWithParameters(urlString: ApiEndPoints.createBatch, params: (param as NSDictionary) as! Dictionary<String, AnyObject>) { (response, error) in
//            LoadingIndicatorView.hide()
//            let resultDict = response as NSDictionary?
//            if let error = resultDict?.object(forKey: "error") as? String{//error
//                self.showAlert(title: "Alert", message: error)
//            }else { //sucess
//               // let successStr = resultDict?["success"] as! String
//                self.showAlert(title: "Alert", message: "Syllabus add sucessfully!")
//               // print(successStr)
//            }
//            LoadingIndicatorView.hide()
//        }
    }
    
    // MARK: - Enroll Sucess View
    func showCustomSucessDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let exitVc = self.storyboard?.instantiateViewController(withIdentifier: "AddSyllabusPopView") as? AddSyllabusPopView
        
        
        
        // Create the dialog
        let popup = PopupDialog(viewController: exitVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        exitVc?.title_lbl.text = "Title"
        exitVc?.addLession_btn.addTargetClosure { _ in
            self.titleStr = (exitVc?.title_textfld.text)!
            self.descriptionStr = (exitVc?.description_txtFld.text)!
            if self.titleStr == ""{
                self.showAlert(title: "Alert", message: "Please enter title!")
            }else if self.descriptionStr == ""{
                self.showAlert(title: "Alert", message: "Please enter description!")
            }else{
            popup.dismiss()
            self.exitBtn()
            }
        }
        present(popup, animated: animated, completion: nil)
    }
    
    func exitBtn(){
            let dic1:NSDictionary = ["course_id": "8", "title": titleStr, "description": descriptionStr]
            self.addlessionArr.append(dic1)
            syllabusTbl_view.reloadData()
            print("total dic count" , self.addlessionArr.count)
            self.tblView_heightConstraints.constant = CGFloat(self.addlessionArr.count*85)
        }
    
    @IBAction func actionAddlession_btn(_ sender: Any) {
        showCustomSucessDialog()
    }
    
        
//        let finalDataDic:NSDictionary = ["data": self.addlessionArr]
//
//        print(finalDataDic)
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: finalDataDic, options: [])
//        let jsonString = String(data: jsonData!, encoding: .utf8)
//        print(jsonString)
        
        
      /*  if title_txtFld.text == ""{
            self.showAlert(title: "Alert", message: "Please enter title!")
        }else if description_txtFld.text == ""{
            self.showAlert(title: "Alert", message: "Please enter description!")
        }else{
            if Connectivity.isConnectedToInternet() {
                addSyllabusApi()
            } else {
                showAlert(title: "No Internet!", message: "Please check your internet connection")
            }
        }*/
    
    @IBAction func actionAddSyllabus_btn(_ sender: Any) {
        if addlessionArr.count == 0{
            self.showAlert(title: "Alert", message: "Please add first lession!")
        }else{
            if Connectivity.isConnectedToInternet() {
                addSyllabusApi()
            } else {
                showAlert(title: "No Internet!", message: "Please check your internet connection")
            }
        }
    }
    
    @IBAction func actionBack_btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableView DataSource
extension AddSyllabusViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addlessionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SyllabusTableViewCell") as! SyllabusTableViewCell
        cell.syllabus_nameLbl.text = addlessionArr[indexPath.row].value(forKey: "title") as? String
        cell.syllabus_descriptionLbl.text = addlessionArr[indexPath.row].value(forKey: "description") as? String
       // cell.syllabus_nameLbl.text = syllabusArr[indexPath.row].title
      //  cell.syllabus_descriptionLbl.text = syllabusArr[indexPath.row].description
        return cell
    }
}

