//
//  CheckboxViewController.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit


class CheckBoxViewController: UIViewController {

    @IBOutlet weak var checkBoxMenu: YRCheckboxMenu!
    @IBOutlet weak var checkBoxLabel: UILabel!
    
    var checkBoxView: YRCheckboxMenu? = nil
    var popupView: YRPopupView? = nil
    let checkBoxItems = ["Item1", "Item2", "Item3", "Item4", "Item5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Checkbox menu with multiple selection
      
        checkBoxMenu.items = checkBoxItems
//        checkBoxMenu.checkboxTitle = "Pick Multiple Options"
//        checkBoxMenu.checkboxSubTitle = "Choose multiple items"
//        checkBoxMenu.checkboxItemTextColour = UIColor.red
//        checkBoxMenu.checkboxViewBackgroundColour = UIColor.white
//        checkBoxMenu.checkboxTitleBackgroundColour = UIColor.white
//        checkBoxMenu.checkboxTitleTextColor = UIColor.blue
//        checkBoxMenu.checkboxSubTitleTextColor = UIColor.blue
//        checkBoxMenu.checkedImage = UIImage(named: "crop")
//        checkBoxMenu.uncheckedImage = UIImage(named: "delete")
//        checkBoxMenu.checkboxColor = UIColor.red
        
    }
    
    @IBAction func popupBtn(_ sender: Any) {
        
        popupView = YRPopupView()
        let checkBoxItems = ["Item1", "Item2", "Item3", "Item4", "Item5"]
        checkBoxView = YRCheckboxMenu()
//        checkBoxView?.selectButton.setTitle("Done", for: .normal)
//        checkBoxView?.cancelButton.setTitle("Close", for: .normal)
//        checkBoxView?.selectButton.setTitleColor(UIColor.red, for: .normal)
        checkBoxView?.isPopupMode = true
        checkBoxView?.items = checkBoxItems
        checkBoxView?.onItemsSelected = {
            (selectedIndexes) in
            var text:String = ""
            for index in self.checkBoxView!.selectedIndexes { 
                text = text + checkBoxItems[index] + ", "
            }
            self.checkBoxLabel.text = text
            print(text)

        }
        popupView?.addPopUpContentView(contentView: checkBoxView!)
        self.view.addSubview(popupView!)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        var text:String = ""
        for index in checkBoxMenu.selectedIndexes {
            text = text + checkBoxItems[index] + ", "
        }
        checkBoxLabel.text = text
    }
    
}
