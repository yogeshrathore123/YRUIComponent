//
//  TextFieldValidationViewController.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit

class TextFieldValidationViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: YRTextField!
    @IBOutlet weak var lastNameTextField: YRTextField!
    @IBOutlet weak var passwordTextField: YRTextField!
    @IBOutlet weak var confirmPasswordTextField: YRTextField!
    @IBOutlet weak var eMailTextField: YRTextField!
    @IBOutlet weak var phoneNumberTextField: YRTextField!
    @IBOutlet weak var numberTextField: YRTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.fieldTuple = (YRFieldType.YRTextFieldTypeName, " Invalid Name ")
        lastNameTextField.fieldTuple = (YRFieldType.YRTextFieldTypeName, " *required")
        eMailTextField.fieldTuple = (YRFieldType.YRFieldTypeEmailNotRequired, " Invalid Email format ")
        passwordTextField.fieldTuple = (YRFieldType.YRFieldTypePassword, "")
        confirmPasswordTextField.confirmTextField = passwordTextField.textField
        confirmPasswordTextField.fieldTuple = (YRFieldType.YRTextFieldTypeConfirmPassword, "")
        phoneNumberTextField.fieldTuple = (YRFieldType.YRFieldTypePhoneNumberRequired, " Invalid phone number ")
        numberTextField.fieldTuple = (YRFieldType.YRTextFieldTypeNumberOnly, "Only Number")
    }
    
}
