//
//  HomeViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 25/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class HomeViewController: BaseClassViewController,UITextFieldDelegate {
    
    @IBOutlet weak var categoryTbl_view: UITableView!
    @IBOutlet weak var search_txtFld: UITextField!
    @IBOutlet weak var noDataImg_view: UIImageView!
    @IBOutlet weak var noData_lbl: UILabel!
    
    static var index = 0
    let cellSpacingHeight: CGFloat = 20
    var develompentArr = [String]()
    var courseArr = [getAllCourse.course]()
    var filteredArr = [getAllCourse.course]()
    var isSearching = Bool()
    private let refreshControl = UIRefreshControl()
    
    
    // MARK: - App Life Cycle Method
    override func viewDidLoad(){
        super.viewDidLoad()
        if Connectivity.isConnectedToInternet() {
            // courseArr.removeAll()
            tutorCourseApi()
        } else {
            showAlert(title: "No Internet!", message: "Please check your internet connection")
        }
        categoryTbl_view.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        categoryTbl_view.tableFooterView = UIView()
        self.tabBarController?.tabBar.isHidden = false
        search_txtFld.delegate = self
        // Add Refresh Control to Table View
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        categoryTbl_view.addSubview(refreshControl)
        noDataImg_view.isHidden = true
        noData_lbl.isHidden = true
    }
    
    @objc func refresh(sender:AnyObject) {
        if Connectivity.isConnectedToInternet() {
            // courseArr.removeAll()
            tutorCourseApi()
        } else {
            showAlert(title: "No Internet!", message: "Please check your internet connection")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    //  MARK: - Get All Course Api
    func tutorCourseApi(){
        // showCustomProgress()
        LoadingIndicatorView.show()
        WebserviceSigleton.shared.GETService(urlString: ApiEndPoints.getAllCourse) { (response, error) in
            if error == nil{
                LoadingIndicatorView.hide()
                self.refreshControl.endRefreshing()
                let resultDict = response as NSDictionary?
                self.courseArr.removeAll()
                if (resultDict?["success"]) != nil{
                    if let sucessDict = resultDict?["success"] as? NSDictionary{
                        let dataArr = sucessDict["data"] as? [AnyObject]
                        if dataArr?.count == 0{
                            self.categoryTbl_view.isHidden = true
                            self.noDataImg_view.isHidden = false
                            self.noData_lbl.isHidden = false
                        }
                        for obj in dataArr!{
                            let course = getAllCourse.course(
                                id: obj["id"] as? Int,
                                name: obj["name"] as? String,
                                des: obj["description"] as? String,
                                fee: obj["fee"] as? String,
                                category_id: obj["category_id"] as? Int,
                                status: obj["status"] as? String,
                                created_at: obj["created_at"] as? String,
                                updated_at: obj["created_at"] as? String,
                                imageProfile: obj["imageProfile"] as? String)
                            self.courseArr.append(course)
                            print(self.courseArr)
                            self.categoryTbl_view.reloadData()
                        }
                    }
                }
            }else{
                self.showAlert(title: "Alert", message: "No Data Found!")
            }
            // self.stopProgress()
        }
    }
    
    // MARK: - Text Filed Should ChangeCharactersIn
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        isSearching = true
        if string.count < 1 {
            //filteredArr = courseArr
            isSearching = false
            self.categoryTbl_view.reloadData()
        } else {
            filteredArr.removeAll()
            for filteredName in courseArr {
                if let name = filteredName.name , let description = filteredName.des {
                    if name.lowercased().contains(textField.text!.lowercased()) || description.lowercased().contains(textField.text!.lowercased()) {
                        filteredArr.append(filteredName)
                    }
                }
            }
        }
        self.categoryTbl_view.reloadData()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
        // categoryTbl_view.reloadData()
        return true
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
        if isSearching == true{
            return filteredArr.count
        }else{
            return courseArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        if isSearching == true{
            cell.title_lbl.text = filteredArr[indexPath.row].name
            cell.description_lbl.text = filteredArr[indexPath.row].des
            if let imgProfile = filteredArr[indexPath.row].imageProfile{
                let imageStr = Configurator.courseImageBaseUrl + imgProfile
                cell.categoryImg_view.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "development"))
            }
            if let feesStr = filteredArr[indexPath.row].fee{
               cell.price_lbl.text = "$" + " " + feesStr.description
            }
            if let dateStr = filteredArr[indexPath.row].created_at{
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "dd MMMM yyyy hh:mm aa"
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "dd MMMM yyyy"
                if let date = dateFormatterGet.date(from:  dateStr) {
                    cell.date_lbl.text = dateFormatterPrint.string(from: date)
                }
            }
        }else{
            cell.title_lbl.text = courseArr[indexPath.row].name
            cell.description_lbl.text = courseArr[indexPath.row].des
            if let imagStr = courseArr[indexPath.row].imageProfile{
            let imageStr = Configurator.courseImageBaseUrl + imagStr
            cell.categoryImg_view.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "development"))
            }
            if let feesStr = courseArr[indexPath.row].fee{
               cell.price_lbl.text = "$" + " " + feesStr
            }
            if let dateStr = courseArr[indexPath.row].created_at{
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd MMMM yyyy hh:mm aa"
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "dd MMMM yyyy"
            if courseArr[indexPath.row].created_at != nil{
                if let date = dateFormatterGet.date(from:  dateStr) {
                    cell.date_lbl.text = dateFormatterPrint.string(from: date)
                }
            }
           }
        }
        return cell
    }
}

// MARK: - UITableView Delegate
extension HomeViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailsViewController") as! CourseDetailsViewController
        if isSearching == true{
            obj.courseDetails = filteredArr[indexPath.row]
            obj.courseName = filteredArr[indexPath.row].name!
            self.navigationController?.pushViewController(obj, animated: true)
        }else{
            obj.courseDetails = courseArr[indexPath.row]
            obj.courseName = courseArr[indexPath.row].name!
            self.navigationController?.pushViewController(obj, animated: true)
        }
    }
}
