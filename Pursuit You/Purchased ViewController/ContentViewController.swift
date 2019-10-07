//
//  ContentViewController.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit

private func yal_isPhone6() -> Bool {
    let size = UIScreen.main.bounds.size
    let minSide = min(size.height, size.width)
    let maxSide = max(size.height, size.width)
    return (abs(minSide - 375.0) < 0.01) && (abs(maxSide - 667.0) < 0.01)
}

//class ExampleTableViewCell: UITableViewCell {
//}

class ContentViewController: UIViewController {
    
    @IBOutlet fileprivate weak var hintTableView: UITableView!
    @IBOutlet fileprivate weak var bottomCardConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var heightConstraint: NSLayoutConstraint!
    
    var disaster: Disaster?
    fileprivate var hints: [String]?
    
    class func create() -> ContentViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! ContentViewController
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hintTableView.register(UINib(nibName: "PurchasedTableViewCell", bundle: nil), forCellReuseIdentifier: "PurchasedTableViewCell")
        hintTableView.rowHeight = 130
       // hintTableView.estimatedRowHeight = 1000
        
        if let disaster = disaster {
            hints = disaster.hints
        }
    }
}

extension ContentViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchasedTableViewCell", for: indexPath) as! PurchasedTableViewCell
        return cell
    }
    
}
