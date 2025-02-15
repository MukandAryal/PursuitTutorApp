//
//  ExampleViewController.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit
import Segmentio

class ExampleViewController: UIViewController {
    
    var segmentioStyle = SegmentioStyle.imageOverLabel
    
    @IBOutlet private var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var segmentioView: Segmentio!
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var scrollView: UIScrollView!
    
    private lazy var viewControllers: [UIViewController] = {
        return self.preparedViewControllers()
    }()
    
    // MARK: - Init
    
    class func create() -> ExampleViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        return board.instantiateViewController(withIdentifier: String(describing: self)) as! ExampleViewController
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
        return 1
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
    
    // MARK: - Actions
    
    private func goToControllerAtIndex(_ index: Int) {
        segmentioView.selectedSegmentioIndex = index
    }
}

extension ExampleViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        segmentioView.selectedSegmentioIndex = Int(currentPage)
        print("currentPage>>>>.",currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
}
