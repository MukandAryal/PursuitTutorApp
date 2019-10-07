//
//  DashBroadViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 24/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class DashBroadViewController: UIViewController {
    @IBOutlet weak var dashBroad_CollectionView: UICollectionView!
    @IBOutlet weak var page_controller: UIPageControl!
    let nextItem = NSIndexPath(row: 1, section: 0)

    // MARK: - App Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let nib = UINib(nibName: "FirstDashBroadCollectionViewCell", bundle: nil)
        dashBroad_CollectionView?.register(nib, forCellWithReuseIdentifier: "FirstDashBroadCollectionViewCell")
        
        let nibSecond = UINib(nibName: "SecondDashBroadCollectionViewCell", bundle: nil)
        dashBroad_CollectionView?.register(nibSecond, forCellWithReuseIdentifier: "SecondDashBroadCollectionViewCell")
        page_controller.hidesForSinglePage = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Button Action
    @objc func skipButtonClicked() {
      let obj = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewViewController") as! LoginViewViewController
      self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @objc func nextButtonClicked() {
        let visibleItems: NSArray = self.dashBroad_CollectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        self.dashBroad_CollectionView.scrollToItem(at: nextItem, at: .left, animated: true)
    }
    
    @objc func nextFinalClicked() {
        print("nextButtonClicked Clicked")
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewViewController") as! LoginViewViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

// MARK: - UICollectionView DataSource

extension DashBroadViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.page_controller.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstDashBroadCollectionViewCell", for: indexPath) as! FirstDashBroadCollectionViewCell
            cell.backgroundColor = appThemeColor
            cell.skipView.backgroundColor = appThemeColor
            cell.next_view.backgroundColor = appThemeColor
            cell.description_lbl.text = "Pursuit You Provides\n lot of courses which is\n affordabe and contrain\n excellent content"
            cell.skip_btn.addTarget(self, action:#selector(self.skipButtonClicked), for: .touchUpInside)
            cell.next_btn.addTarget(self, action:#selector(self.nextButtonClicked), for: .touchUpInside)
            page_controller.currentPageIndicatorTintColor = appThemeColor
            return cell
        }else if indexPath.row == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondDashBroadCollectionViewCell", for: indexPath) as! SecondDashBroadCollectionViewCell
            cell.backgroundColor = secondDashBroadThemeColor
            cell.skipView.backgroundColor = secondDashBroadThemeColor
            cell.next_view.backgroundColor = secondDashBroadThemeColor
            cell.title_lbl.text = "Watch and learn via Live\nsession"
            cell.description_lbl.text = "Ask questions in Chat Bot"
            let yourImage: UIImage = UIImage(named: "chats_ic.png")!
            cell.appLogo_imgView.image = yourImage
            cell.appLogo_imgView.tintColor = UIColor.white
            cell.skip_btn.addTarget(self, action:#selector(self.skipButtonClicked), for: .touchUpInside)
            cell.next_btn.addTarget(self, action:#selector(self.nextButtonClicked), for: .touchUpInside)
            cell.skip_btn.isHidden = false
            cell.skipView.isHidden = false
            page_controller.currentPageIndicatorTintColor = UIColor.red
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondDashBroadCollectionViewCell", for: indexPath) as! SecondDashBroadCollectionViewCell
            cell.backgroundColor = thirdDashBroadThemeColor
            cell.skipView.backgroundColor = thirdDashBroadThemeColor
            cell.next_view.backgroundColor = thirdDashBroadThemeColor
            cell.title_lbl.text = "Like the Course!!"
            cell.description_lbl.text = "Give the tips to tutor,review\n the course with nice rating and\n comments"
            let yourImage: UIImage = UIImage(named: "smile_ic.png")!
            cell.appLogo_imgView.image = yourImage
            cell.appLogo_imgView.tintColor = UIColor.white
            cell.skip_btn.isHidden = true
            cell.skipView.isHidden = true
            page_controller.currentPageIndicatorTintColor = thirdDashBroadThemeColor
            cell.next_btn.addTarget(self, action:#selector(self.nextFinalClicked), for: .touchUpInside)
            return cell
        }
    }
}

// MARK: - UICollectionView ViewDelegate
extension DashBroadViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstDashBroadCollectionViewCell", for: indexPath) as! FirstDashBroadCollectionViewCell
     //   cell.backgroundColor = UIColor.green
        if indexPath.row == 0 {
            cell.backgroundColor = UIColor(red: 83/254, green: 177/254, blue: 240/254, alpha: 1.0)
        }else if indexPath.row == 1{
            cell.backgroundColor = UIColor.purple
        }else{
            cell.backgroundColor = UIColor.green
        }
    }
}



