//
//  SearchViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 30/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit
import SDWebImage

class SearchViewController: BaseClassViewController,UISearchBarDelegate {

    @IBOutlet weak var search_bar: UISearchBar!
    @IBOutlet weak var searchTblView: UITableView!
    var categroyArr = [getAllCourse.allCategory]()
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        search_bar.backgroundImage = UIImage()
          searchTblView.register(UINib(nibName: "SearchCourseTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchCourseTableViewCell")
        searchBarSearchButtonClicked(search_bar)
        tutorCourseApi()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.search_bar.endEditing(true)
    }
    
    // MARK: - Get All Course Api
    func tutorCourseApi(){
        showCustomProgress()
        WebserviceSigleton.shared.GETService(urlString: ApiEndPoints.category) { (response, error) in
            if error == nil{
                let resultDict = response as NSDictionary?
                if (resultDict?["success"]) != nil{
                    if let sucessDict = resultDict?["success"] as? NSDictionary{
                        let dataArr = sucessDict["data"] as? [AnyObject]
                        for obj in dataArr!{
                            let course = getAllCourse.allCategory(
                                id:obj["id"] as? Int,
                                name:obj["name"] as? String,
                                image: obj["image"] as? String,
                                status: obj["status"] as? String,
                                created_at: obj["created_at"] as? String,
                                updated_at: obj["created_at"] as? String)
                            self.categroyArr.append(course)
                            self.searchTblView.reloadData()
                        }
                    }
                }
            }else{
                self.showAlert(title: "Alert", message: "server issue please try again")
            }
            self.stopProgress()
        }
    }
    
    
    @IBAction func actionNotification_btn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "NotifcationViewController") as! NotifcationViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

extension SearchViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categroyArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 155
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCourseTableViewCell") as! SearchCourseTableViewCell
        cell.category_nameLbl.text = categroyArr[indexPath.row].name
        let img =  categroyArr[indexPath.row].image
        let imageStr = Configurator.imageBaseUrl + img!
        cell.category_imgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
        return cell
    }
}

extension SearchViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetailsListViewController") as? CategoryDetailsListViewController
        obj?.categoryId = categroyArr[indexPath.row].id!
        obj?.categoryName = categroyArr[indexPath.row].name!
        self.navigationController?.pushViewController(obj!, animated: true)
    }
}

