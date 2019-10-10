//
//  RewardsViewController.swift
//  Pursuit TutorApp
//
//  Created by Apple SSD2 on 07/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class RewardsViewController: UIViewController {

    @IBOutlet weak var rewardsTbl_view: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         rewardsTbl_view.register(UINib(nibName: "RewardsTableViewCell", bundle: nil), forCellReuseIdentifier: "RewardsTableViewCell")
    }
    
    @IBAction func action_notification(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "NotifcationViewController") as! NotifcationViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

extension RewardsViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsTableViewCell") as! RewardsTableViewCell
        
        return cell
    }
}

extension RewardsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let obj = self.storyboard?.instantiateViewController(withIdentifier: "RewardsTableViewCell") as! notifo
        //self.navigationController?.pushViewController(obj, animated: true)
    }
    
}

