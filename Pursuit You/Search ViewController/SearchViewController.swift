//
//  SearchViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 30/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var search_bar: UISearchBar!
    @IBOutlet weak var searchTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        search_bar.backgroundImage = UIImage()
          searchTblView.register(UINib(nibName: "SearchCourseTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchCourseTableViewCell")
        searchBarSearchButtonClicked(search_bar)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.search_bar.endEditing(true)
    }
    
    @IBAction func actionNotification_btn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "NotifcationViewController") as! NotifcationViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

extension SearchViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 155
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCourseTableViewCell") as! SearchCourseTableViewCell
        
        return cell
    }
}

extension SearchViewController : UITableViewDelegate{
    
}

