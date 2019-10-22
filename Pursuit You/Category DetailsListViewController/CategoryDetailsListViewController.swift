//
//  CategoryDetailsListViewController.swift
//  Pursuit TutorApp
//
//  Created by Apple SSD2 on 09/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class CategoryDetailsListViewController: BaseClassViewController {
    
    
    @IBOutlet weak var categoryTbl_view: UITableView!
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var noCourse_imgView: UIImageView!
    @IBOutlet weak var noCourse_lbl: UILabel!
    
    static var index = 0
    let cellSpacingHeight: CGFloat = 20
    var develompentArr = [String]()
    var categoryId = Int()
    var categoryName = String()
    var courseArr = [getAllCourse.course]()
    
    // MARK: - App Life Cycle Method
    public override func viewDidLoad() {
        categoryTbl_view.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        title_lbl.text = categoryName
        noCourse_imgView.isHidden = true
        noCourse_lbl.isHidden = true
        tutorCoursesByCategoryApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    //  MARK: - Get All Course Api
    func tutorCoursesByCategoryApi(){
        LoadingIndicatorView.show()
        let urlApi = ApiEndPoints.coursesByCategory +  "?category_id=\(categoryId)"
        print("urlApi>",urlApi)
        WebserviceSigleton.shared.GETService(urlString: urlApi) { (response, error) in
            if error == nil{
                LoadingIndicatorView.hide()
                let resultDict = response as NSDictionary?
                if (resultDict?["success"]) != nil{
                    if let sucessDict = resultDict?["success"] as? NSDictionary{
                        let dataArr = sucessDict["data"] as? [AnyObject]
                        if dataArr?.count == 0 {
                            self.noCourse_imgView.isHidden = false
                            self.noCourse_lbl.isHidden = false
                            self.categoryTbl_view.isHidden = true
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
                                updated_at: obj["updated_at"] as? String,
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
            LoadingIndicatorView.hide()
        }
    }
    
    @IBAction func actionback_btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Button Action
    @IBAction func actionNotification_btn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "NotifcationViewController") as! NotifcationViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

// MARK: - UITableView DataSource
extension CategoryDetailsListViewController : UITableViewDataSource{
    
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
        let imageStr = Configurator.courseImageBaseUrl + courseArr[indexPath.row].imageProfile!
        cell.categoryImg_view.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "development"))
        cell.price_lbl.text = "$" + " " + courseArr[indexPath.row].fee!.description
        return cell
    }
}

// MARK: - UITableView Delegate
extension CategoryDetailsListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailsViewController") as! CourseDetailsViewController
        obj.courseDetails = courseArr[indexPath.row]
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

