//
//  DropDownViewController.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit

class DropDownViewController: UIViewController {

    @IBOutlet weak var bottomUpDropDownView: YRDropDownView!
    @IBOutlet weak var topDownDropDownView: YRDropDownView!
    
    var popupView: YRPopupView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTopDownDropDown()
        addBottomUpDropDown()
    }
    
    func addTopDownDropDown() {
        //DropDownMenu with selection
        var items: [YRDropDownItem] = []
    
        items.append(YRDropDownItem(title: "item1", image: UIImage(named: "1")!))
        items.append(YRDropDownItem(title: "item3", image: UIImage(named: "3")!))
        items.append(YRDropDownItem(title: "item4", image: UIImage(named: "4")!))
        items.append(YRDropDownItem(title: "itemStar", image: UIImage(named: "star")!))
        
        topDownDropDownView.items = items
//        topDownDropDownView.dropDownMode = .TopDown
//        topDownDropDownView.upArrowImage = UIImage(named: "crop")!
//        topDownDropDownView.downArrowImage = UIImage(named: "delete")!
//        topDownDropDownView.dropDownTitleBackgroundColour = UIColor.white
//        topDownDropDownView.dropDownViewBackgroundColour = UIColor.white
//        topDownDropDownView.dropDownTitleTextColor = UIColor.black
//        topDownDropDownView.dropDownTitle = "TopDown"
//        topDownDropDownView.dropDownViewBorderColor = UIColor.black
//        topDownDropDownView.dropDownViewBorderWidth = 2
//        topDownDropDownView.dropDownItemTextColour = UIColor.blue
        topDownDropDownView.onItemSelected = {
            (selectedIndex) in
            //User Code to handle item selection
            print("Item selected \(items[selectedIndex])")
        }
    }
    
    func addBottomUpDropDown() {
        //DropDownMenu with selection
        
        var items: [YRDropDownItem] = []
        items.append(YRDropDownItem(title: "item1", image: nil))
        items.append(YRDropDownItem(title: "item3", image: UIImage(named: "3")))
        items.append(YRDropDownItem(title: "item4", image: UIImage(named: "4")))
        items.append(YRDropDownItem(title: "itemStar", image: UIImage(named: "star")))
        
        bottomUpDropDownView.items = items
        bottomUpDropDownView.dropDownMode = .BottomUp
        bottomUpDropDownView.onItemSelected = {
            (selectedIndex) in
            //User Code to handle item selection
            print("Item selected \(items[selectedIndex])")
        }
    }
    
  
}
