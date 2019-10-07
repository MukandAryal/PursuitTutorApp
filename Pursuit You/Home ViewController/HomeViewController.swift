//
//  HomeViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 25/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import DropDown


class HomeViewController: UIViewController {
    
    @IBOutlet weak var categoryTbl_view: UITableView!
    @IBOutlet weak var develompent_btn: UIButton!
    @IBOutlet weak var develompent_lbl: UILabel!
    
    let dropDownSingle = DropDown()
    static var index = 0
    let cellSpacingHeight: CGFloat = 20
    var develompentArr = [String]()
    
    
    public override func viewDidLoad() {
        
        categoryTbl_view.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        self.tabBarController?.tabBar.isHidden = false
        develompentArr = ["Develompent","Digital Marketing","SCO","Content Writing","Business","IT Solutions"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func configureDropDown(tag:Int) {
        self.dropDownSingle.backgroundColor = UIColor.white
        self.dropDownSingle.dismissMode  = .automatic
        dropDownSingle.selectionBackgroundColor = UIColor(red: 234/255, green: 245/255, blue: 255/255, alpha: 1.0)
        
        if tag == 1 {
            dropDownSingle.anchorView = self.develompent_lbl
            dropDownSingle.dataSource = develompentArr
            dropDownSingle.width = self.develompent_lbl.frame.size.width
            dropDownSingle.selectionBackgroundColor = UIColor.clear
        }
        dropDownSingle.selectionAction = { [unowned self] (index: Int, item: String) in
            if tag == 1 {
                self.develompent_lbl.text = item
                //self.gender_textFld.textColor = .black
            }
        }
    }
    
    
    @objc public func homePageAction() {
        //        let vc = WebViewController.instanceFromStoryBoard()
        //        vc.hidesBottomBarWhenPushed = true
        //        if let navigationController = navigationController {
        //            navigationController.pushViewController(vc, animated: true)
        //            return
        //        }
        //        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func actionDevelopmentBtn(_ sender: Any) {
        self.view.endEditing(true)
        self.configureDropDown(tag: 1)
        self.dropDownSingle.show()
    }
    @IBAction func actionNotification_btn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "NotifcationViewController") as! NotifcationViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

extension HomeViewController : UITableViewDataSource{
    
//    // Set the spacing between sections
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return cellSpacingHeight
//    }
//    
//    // Make the background color show through
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.clear
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        cell.description_lbl.text = "Php is a server side scripting language.that usse the develop static websites."
        return cell
    }
}

extension HomeViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailsViewController") as! CourseDetailsViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}
