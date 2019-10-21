//
//  SearchViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 30/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit
import SDWebImage

class SearchViewController: BaseClassViewController,UITextFieldDelegate {
    
    @IBOutlet weak var searchTblView: UITableView!
    var categroyArr = [getAllCourse.allCategory]()
    var searchcourseArr = [getAllCourse.course]()
    var filteredArr = [getAllCourse.allCategory]()
    @IBOutlet weak var search_txtFld: UITextField!
    
    var isSearching = Bool()
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if Connectivity.isConnectedToInternet() {
           // categroyArr.removeAll()
            tutorCourseApi()
        } else {
            showAlert(title: "No Internet!", message: "Please check your internet connection")
        }
        searchTblView.register(UINib(nibName: "SearchCourseTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchCourseTableViewCell")
        searchTblView.allowsSelectionDuringEditing = false
        search_txtFld.delegate = self
       // isSearching = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        // self.search_bar.endEditing(true)
    }
    
    // MARK: - Get All Course Api
    func tutorCourseApi(){
      //  showCustomProgress()
        LoadingIndicatorView.show()
        WebserviceSigleton.shared.GETService(urlString: ApiEndPoints.category) { (response, error) in
            LoadingIndicatorView.hide()
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        isSearching = true
         if string.count < 1 {
            //filteredArr = categroyArr
             isSearching = false
             searchTblView.reloadData()
        } else {
            filteredArr.removeAll()
        
            for filteredName in categroyArr {
                if filteredName.name!.lowercased().contains(textField.text!.lowercased()){
                    print("filteredName>>>>>>>",filteredName)
                    filteredArr.append(filteredName)
                   }
                }
                self.searchTblView.reloadData()
            }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
       // isSearching = false
       // searchTblView.reloadData()
        return true
    }
    
    @IBAction func actionNotification_btn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "NotifcationViewController") as! NotifcationViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}


extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}

extension SearchViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching == true {
            return filteredArr.count
        }else{
            return categroyArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isSearching == true {
            return 155
        }else{
            return 155
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCourseTableViewCell") as! SearchCourseTableViewCell
        if isSearching == true {
            cell.category_nameLbl.text = filteredArr[indexPath.row].name
            let img =  filteredArr[indexPath.row].image
            let imageStr = Configurator.imageBaseUrl + img!
            cell.category_imgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
            return cell
        }else{
            cell.category_nameLbl.text = categroyArr[indexPath.row].name
            let img =  categroyArr[indexPath.row].image
            let imageStr = Configurator.imageBaseUrl + (img)! 
            cell.category_imgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
            return cell
        }
    }
}

extension SearchViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching == true {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetailsListViewController") as? CategoryDetailsListViewController
            obj?.categoryId = filteredArr[indexPath.row].id!
            obj?.categoryName = filteredArr[indexPath.row].name!
            self.navigationController?.pushViewController(obj!, animated: true)
        }else{
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetailsListViewController") as? CategoryDetailsListViewController
        obj?.categoryId = categroyArr[indexPath.row].id!
        obj?.categoryName = categroyArr[indexPath.row].name!
        self.navigationController?.pushViewController(obj!, animated: true)
        }
    }
}

