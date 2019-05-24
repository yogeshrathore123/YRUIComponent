//
//  DateTimePickerViewController.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit


class DateTimePickerViewController: UIViewController {
    
    @IBOutlet weak var dateTextField1: UITextField!
    @IBOutlet weak var dateTextField2: UITextField!
    @IBOutlet weak var dateTextField3: UITextField!
    var datePicker1 = UIDatePicker()
    var datePicker2 = UIDatePicker()
    var datePicker3 = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customiseDateTimePickers()
    }
    
    func customiseDateTimePickers() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let minDate = formatter.date(from: "2017/01/01")
        let maxDate = formatter.date(from: "2020/01/02")
        
        dateTextField1.inputView = datePicker1
        datePicker1.setMinMaxDate(maxDate: maxDate!, minDate: minDate!)
        datePicker1.setTimePickerFormat(is24Hour: true)
        datePicker1.backgroundColor = UIColor.white
        datePicker1.setDatePicker(mode: .date)
        datePicker1.addControlButtons(textField: dateTextField1, doneButtonAction: #selector(doneButton1Clicked), cancelButtonAction: #selector(cancelButtonClicked))

        dateTextField2.inputView = datePicker2
        datePicker2.setTodayAsMinDate()
        datePicker2.setTimePickerFormat(is24Hour: true)
        datePicker2.backgroundColor = UIColor.white
        datePicker2.setDatePicker(mode: .date)
        datePicker2.addControlButtons(textField: dateTextField2, doneButtonAction: #selector(doneButton2Clicked), cancelButtonAction: #selector(cancelButtonClicked))
        
        dateTextField3.inputView = datePicker3
        datePicker3.setTodayAsMaxDate()
        datePicker3.setTimePickerFormat(is24Hour: true)
        datePicker3.backgroundColor = UIColor.white
        datePicker3.setDatePicker(mode: .date)
        datePicker3.addControlButtons(textField: dateTextField3, doneButtonAction: #selector(doneButton3Clicked), cancelButtonAction: #selector(cancelButtonClicked))
        
    }
    
//    func customiseDateTimePicker() {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd"
//        let minDate = formatter.date(from: "2017/01/01")
//        let maxDate = formatter.date(from: "2020/01/02")
//
////        datePicker = UIDatePicker()
//        dateTextField1.inputView = datePicker
//        datePicker?.setMinMaxDate(maxDate: maxDate!, minDate: minDate!)
//        datePicker?.setTimePickerFormat(is24Hour: true)
//        datePicker?.setTodayAsMinDate()
//        datePicker?.setTodayAsMaxDate()
//        datePicker?.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
//        datePicker?.setDatePicker(mode: .date)
//        datePicker?.addControlButtons(textField: dateTextField, doneButtonAction: #selector(doneButtonClicked), cancelButtonAction: #selector(cancelButtonClicked))
//    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
//        let hour = sender.calendar.component(.hour, from: sender.date)
        let month = sender.calendar.component(.month, from: sender.date)
//        let minute = sender.calendar.component(.minute, from: sender.date)
        let year = sender.calendar.component(.year, from: sender.date)
        let day = sender.calendar.component(.day, from: sender.date)
        var textField: UITextField?
        switch sender {
        case datePicker1:
            textField = dateTextField1
        case datePicker2:
            textField = dateTextField2
        case datePicker3:
            textField = dateTextField3
        default:
            textField = dateTextField1
        }
//        textField!.text =  "\(day)/\(month)/\(year)  \(hour):\(minute)"
        textField!.text =  "\(day)/\(month)/\(year)"
    }
    
    @objc func doneButton1Clicked() {
        datePickerValueChanged(datePicker1)
        print("Done Clicked")
        view.endEditing(true)
       
    }
    
    @objc func doneButton2Clicked() {
        datePickerValueChanged(datePicker2)
        print("Done Clicked")
        view.endEditing(true)
        
    }
    
    @objc func doneButton3Clicked() {
        datePickerValueChanged(datePicker3)
        print("Done Clicked")
        view.endEditing(true)
        
    }
    
    @objc func cancelButtonClicked() {
        print("Cancel Clicked")
        view.endEditing(true)
    }
}
