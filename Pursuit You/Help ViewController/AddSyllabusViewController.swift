//
//  AddSyllabusViewController.swift
//  Pursuit TutorApp
//
//  Created by Apple SSD2 on 21/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit
import Alamofire

class AddSyllabusViewController: BaseClassViewController {
    
    @IBOutlet weak var syllabusTbl_view: UITableView!
    @IBOutlet weak var lession_lbl: UILabel!
    @IBOutlet weak var addSyllabus_lbl: UIButton!
    @IBOutlet weak var course_nameLbl: UILabel!
    var syllabusArr = [getAllCourse.syllabusInfo]()
    var courseProgressDetails = getAllCourse.allTutorCourse()
    var titleStr = String()
    var descriptionStr = String()
    var addlessionArr = [NSDictionary]()
    var finalDict : [String:Any] = [:]
    var window: UIWindow?
    var courseName = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syllabusTbl_view.register(UINib(nibName: "SyllabusTableViewCell", bundle: nil), forCellReuseIdentifier: "SyllabusTableViewCell")
        course_nameLbl.text = courseName
        syllabusTbl_view.tableFooterView = UIView()
        addSyllabus_lbl.isHidden = true
    }
    
//    //  MARK: - Get All Course Api
//    func syllabusApi(){
//        // showCustomProgress()
//        LoadingIndicatorView.show()
//        let urlApi = ApiEndPoints.syllabus +  "?course_id=\(String(describing: courseProgressDetails.course_id))" +  "&&tutor_id=\(String(describing: courseProgressDetails.tutor_relation_id))"
//        print("urlApi>",urlApi)
//        WebserviceSigleton.shared.GETService(urlString: urlApi) { (response, error) in
//            if error == nil{
//                let resultDict = response as NSDictionary?
//                LoadingIndicatorView.hide()
//                if (resultDict?["success"]) != nil{
//                    if let sucessDict = resultDict?["success"] as? [AnyObject]{
//                        if sucessDict.count == 0 {
//                        }
//                        for obj in sucessDict{
//                            let course = getAllCourse.syllabusInfo(
//                                id: obj["id"] as? Int,
//                                course_id: obj["course_id"] as? Int,
//                                tutor_id: obj["tutor_id"] as? Int,
//                                title: obj["title"] as? String,
//                                description: obj["description"] as? String,
//                                status: obj["status"] as? String,
//                                created_at: obj["created_at"] as? String,
//                                updated_at: obj["created_at"] as? String)
//                            self.syllabusArr.append(course)
//                            self.syllabusTbl_view.reloadData()
//                        }
//                    }
//                }else{
//                    self.showAlert(title: "Alert", message: "No Data Found!")
//                }
//                LoadingIndicatorView.hide()
//                self.showAlert(title: "Alert", message: "No Data Found!")
//            }
//        }
//    }
    
    func convertDictionaryToJsonString(dict: [NSDictionary]) -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions())
        if let jsonString = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue) {
            return "\(jsonString)"
        }
        return ""
    }
    
    func convertDictionaryToJsonString(dict: NSMutableDictionary) -> String? {
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions())
        if let jsonString = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue) {
            return "\(jsonString)"
        }
        return nil
    }
    
    // MARK: - Add Syllabus Implement
    func addSyllabusApi(){
        LoadingIndicatorView.show()
        let finalDic:NSMutableDictionary = ["data": self.addlessionArr]
        if let strJson = self.convertDictionaryToJsonString(dict: finalDic) {
            print("ergfrfhfh" , strJson)
            
            // create post request
            let url = URL(string: Configurator.baseURL + ApiEndPoints.createSyllabus)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            // print(strJson.data(using: .utf8) as Any)
            let token = Configurator.tokenBearer + userDefault.string(forKey: userDefualtKeys.user_Token.rawValue)!
            request.setValue("application/json" , forHTTPHeaderField: "Accept")
            request.setValue(token , forHTTPHeaderField: "Authorization")
            request.httpBody = self.convertDictionaryToJsonString(dict: finalDic)!.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                // print(response)
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                LoadingIndicatorView.hide()
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                    self.showAddSylaabusCustomSucessDialog()
                }
            }
            task.resume()
        }
        //LoadingIndicatorView.hide()
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
        if self.titleStr == ""{
            self.showAlert(title: "Alert", message: "Please enter title!")
        }else if self.descriptionStr == ""{
            self.showAlert(title: "Alert", message: "Please enter description!")
        }else{
            let dic1:NSDictionary = ["course_id": courseProgressDetails.course_id, "title": titleStr, "description": descriptionStr]
            self.addlessionArr.append(dic1)
            syllabusTbl_view.reloadData()
            addSyllabus_lbl.isHidden = false
            print("total dic count" , self.addlessionArr.count)
            print("self.addlessionArr>>>>>>>",self.addlessionArr)
        }
    }
    
    
    // MARK: - Enroll Sucess View
    func showAddSylaabusCustomSucessDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let exitVc = self.storyboard?.instantiateViewController(withIdentifier: "EnrollSucessView") as? EnrollSucessView
        
        
        
        // Create the dialog
        let popup = PopupDialog(viewController: exitVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        exitVc?.msg_lbl.text = "Lesson Added Successfully"
        exitVc?.ok_btn.addTargetClosure { _ in
            popup.dismiss()
            self.doneBtn()
        }
        present(popup, animated: animated, completion: nil)
    }
    
    func doneBtn(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = customIrregularityStyle(delegate: nil)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
    
    @IBAction func actionAddlession_btn(_ sender: Any) {
        showCustomSucessDialog()
    }
    
    @IBAction func actionAddSyllabus_btn(_ sender: Any) {
        if addlessionArr.count == 0{
            self.showAlert(title: "Alert", message: "Please add at least one lession!")
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
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addlessionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SyllabusTableViewCell") as! SyllabusTableViewCell
        cell.syllabus_nameLbl.text = addlessionArr[indexPath.row].value(forKey: "title") as? String
        cell.syllabus_descriptionLbl.text = addlessionArr[indexPath.row].value(forKey: "description") as? String
        cell.lesson_lbl.text = "\(indexPath.row + 1)"
        return cell
    }
}

