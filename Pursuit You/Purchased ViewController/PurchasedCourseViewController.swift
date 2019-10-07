//
//  PurchasedCourseViewController.swift
//  Pursuit You
//
//  Created by Apple SSD2 on 27/09/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit
import Segmentio

private func yal_isPhone6() -> Bool {
    let size = UIScreen.main.bounds.size
    let minSide = min(size.height, size.width)
    let maxSide = max(size.height, size.width)
    return (abs(minSide - 375.0) < 0.01) && (abs(maxSide - 667.0) < 0.01)
}

class ExampleTableViewCell: UITableViewCell {
}
private let animateDuration: TimeInterval = 0.6

class PurchasedCourseViewController: UIViewController {
    
    var segmentioStyle = SegmentioStyle.imageOverLabel
    
    @IBOutlet private var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var segmentioView: Segmentio!
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var scrollView: UIScrollView!
    
    private lazy var viewControllers: [UIViewController] = {
        return self.preparedViewControllers()
    }()
    
    var disaster: Disaster?
    fileprivate var hints: [String]?
    
    // MARK: - Init
    
    class func create() -> PurchasedCourseViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        return board.instantiateViewController(withIdentifier: String(describing: self)) as! PurchasedCourseViewController
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch segmentioStyle {
        case .onlyLabel, .imageBeforeLabel, .imageAfterLabel:
            segmentViewHeightConstraint.constant = 50
        case .onlyImage:
            segmentViewHeightConstraint.constant = 100
        default:
            break
        }
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupScrollView()
        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: segmentioStyle
        )
        // SegmentioBuilder.setupBadgeCountForIndex(segmentioView, index: 1)
        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            if let scrollViewWidth = self?.scrollView.frame.width {
                let contentOffsetX = scrollViewWidth * CGFloat(segmentIndex)
                self?.scrollView.setContentOffset(
                    CGPoint(x: contentOffsetX, y: 0),
                    animated: true
                )
            }
        }
        segmentioView.selectedSegmentioIndex = selectedSegmentioIndex()
    }
    
     // MARK: - Button Action
    @IBAction func actionNotificatio_btn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "NotifcationViewController") as! NotifcationViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    private func goToControllerAtIndex(_ index: Int) {
        segmentioView.selectedSegmentioIndex = index
    }
    
    // Example viewControllers
    private func preparedViewControllers() -> [ContentViewController] {
        let tornadoController = ContentViewController.create()
        tornadoController.disaster = Disaster(
            cardName: "Before tornado",
            hints: Hints.tornado
        )
        
        let earthquakesController = ContentViewController.create()
        earthquakesController.disaster = Disaster(
            cardName: "Before earthquakes",
            hints: Hints.earthquakes
        )
        
        return [
            tornadoController,
            earthquakesController
        ]
    }
    
    private func selectedSegmentioIndex() -> Int {
        return 0
    }
    
    // MARK: - Setup container view
    private func setupScrollView() {
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width * CGFloat(viewControllers.count),
            height: containerView.frame.height
        )
        
        for (index, viewController) in viewControllers.enumerated() {
            viewController.view.frame = CGRect(
                x: UIScreen.main.bounds.width * CGFloat(index),
                y: 0,
                width: view.frame.width,
                height: view.frame.height
            )
            addChild(viewController)
            scrollView.addSubview(viewController.view, options: .useAutoresize) // module's extension
            viewController.didMove(toParent: self)
        }
    }
}

extension PurchasedCourseViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        segmentioView.selectedSegmentioIndex = Int(currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
}

