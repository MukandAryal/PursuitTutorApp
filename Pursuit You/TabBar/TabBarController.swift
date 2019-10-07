//
//  TabBarController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 26/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class TabBarController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tabBarController = customIrregularityStyle(delegate: nil)//tabbarWithNavigationStyle()
        //let navigationController = ExampleNavigationController.init(rootViewController: tabBarController)
        self.present(tabBarController , animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
