//
//  SlideMenuViewController.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit


class SlideMenuViewController: YRMenuBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //MenuItems loading
        let items1: [String] = [ "Home", "CardView", "DateTimePicker"]
        addSlideMenuButton(menuButtonImage: UIImage(named: "radio_checkedd"), items: items1)
        // provide any custom menu image
        menuBackgroundColor = UIColor.cyan
        menuItemTextColor = UIColor.black
        menuItemSelectionColor = UIColor.lightText
    }
    
    override func slideMenuItemSelectedAtIndex(_ index: Int) {
        switch index {
        case 0:
            self.pushController(identifier: "CollectionViewController")
        case 1:
            self.pushController(identifier: "CardViewController")
        case 2:
            self.pushController(identifier: "DateTimePickerViewController")
        default:
            break
        }
    }
}
