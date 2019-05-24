//
//  RadioButtonViewController.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit


class RadioButtonViewController: UIViewController {

    @IBOutlet weak var radioGroupView: YRRadioButtonGroupView!
    
    @IBOutlet weak var radioGroupLabel: UILabel!
    var popupView: YRPopupView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //RadioGroup with selection
        let radioButtonItems = ["Item1", "Item2", "Item3", "Item4", "Item5"]
        radioGroupView.items = radioButtonItems
        radioGroupView.isPopupMode = false
       
//        radioGroupView.radioGroupTitle = "RadioButton Group"
//        radioGroupView.radioGroupSubTitle = "bjhhvg"
//        radioGroupView.radioButtonColor = UIColor.black
        radioGroupView.radioGroupTitleTextColor = UIColor.black
//        radioGroupView.radioButtonTitleBackgroundColour = UIColor.lightGray
        radioGroupView.radioGroupViewBackgroundColour = UIColor.white
//        radioGroupView.radioButtonTextColour = UIColor.black
//        radioGroupView.checkedRadioButtonImage = UIImage(named: "radio_checked")
//        radioGroupView.uncheckedRadioButtonImage = UIImage(named: "radio_unchecked")
        radioGroupView.onItemSelected = {
            (selectedIndex) in
            //User Code to handle item selection
            print("Item selected \(radioButtonItems[selectedIndex])")
            self.radioGroupLabel.text = radioButtonItems[selectedIndex]
        }
    }
    
    @IBAction func radioButtonPopupTapped(_ sender: Any) {
        popupView = YRPopupView()
        
        //RadioGroup with selection
        let radioButtonItems = ["Item1", "Item2", "Item3", "Item4", "Item5"]
        let radioView = YRRadioButtonGroupView()
        radioView.isPopupMode = true
        radioView.items = radioButtonItems
    
//        radioView.radioGroupTitle = "RadioButton Group"
//        radioView.radioGroupTitleTextColor = UIColor.white
//        radioView.radioButtonTitleBackgroundColour = UIColor.black
        radioView.onItemSelected = {
            (selectedIndex) in
            //User Code to handle item selection
            print("Item selected \(radioButtonItems[selectedIndex])")
            self.radioGroupLabel.text = radioButtonItems[selectedIndex]
            
        }
        popupView?.addPopUpContentView(contentView: radioView)
        self.view.addSubview(popupView!)
    }
}
