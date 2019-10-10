//
//  NotifcationViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 01/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class NotifcationViewController: UIViewController {
    
    @IBOutlet weak var notificationTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationTblView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionHelp_btn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

extension NotifcationViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 146
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        
        return cell
    }
}

extension NotifcationViewController : UITableViewDelegate{
    
}

