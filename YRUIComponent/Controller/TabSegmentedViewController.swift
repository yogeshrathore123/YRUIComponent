//
//  PopupViewController.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit


class TabSegmentedViewController: UIViewController {

    var segmentedControl: YRCustomSegmentedControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSegmentedControl()
        self.view.backgroundColor = UIColor.purple
    }
    
    func createSegmentedControl() {
        segmentedControl = YRCustomSegmentedControl.init(frame: CGRect.init(x: 0, y: 60, width: self.view.frame.width, height: 45))
        segmentedControl?.backgroundColor = .white
        segmentedControl?.commaSeperatedButtonTitles = "Title1,Title2,Title3"
        segmentedControl?.addTarget(self, action: #selector(onChangeOfSegment), for: .valueChanged)
        segmentedControl?.selectedSegmentIndex = 0
        segmentedControl?.textColor = UIColor.red
        segmentedControl?.selectorColor = UIColor.blue
        segmentedControl?.selectorTextColor = UIColor.blue
        segmentedControl?.isUnderLinerNeeded = true
        segmentedControl?.underLinerColor = UIColor.red
        self.view.addSubview(segmentedControl!)
    }
    
    @objc func onChangeOfSegment() {
        switch(segmentedControl!.selectedSegmentIndex) {
        case 0:
            self.view.backgroundColor = UIColor.purple
        case 1:
            self.view.backgroundColor = UIColor.orange
        case 2: self.view.backgroundColor = UIColor.red
        default: self.view.backgroundColor = UIColor.purple
        }
    }
    
}
