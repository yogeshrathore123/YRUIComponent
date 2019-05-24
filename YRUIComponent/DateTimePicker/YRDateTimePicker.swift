//
//  YRDateTimePicker.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import Foundation
import UIKit

extension UIDatePicker {
    
    public func setMinMaxDate(maxDate : Date, minDate: Date) {
        self.maximumDate = maxDate
        self.minimumDate = minDate
    }
    
    public func setTodayAsMaxDate() {
        self.maximumDate = Date()
        self.minimumDate = nil
    }
    
    public func setTodayAsMinDate() {
        self.minimumDate = Date()
        self.maximumDate = nil
    }
    
    public func setDatePicker(mode: UIDatePicker.Mode) {
        self.datePickerMode = mode
    }
    
    public func setTimePickerFormat(is24Hour: Bool) {
        if is24Hour {
            self.locale = Locale(identifier: "en_GB")
        } else {
            self.locale = Locale(identifier: "en_US")
        }
    }
    
    public func addControlButtons(textField: UITextField, doneButtonAction: Selector, cancelButtonAction: Selector) {
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: doneButtonAction)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: cancelButtonAction )
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
}

