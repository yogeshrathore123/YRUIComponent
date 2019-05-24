//
//  YRTextField.swift
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit
import Foundation

protocol YRTextFieldDelegate {
    func textChanged(_ text: String)
    func YRTextFieldShouldReturn(_ textField: UITextField) -> Bool
    func YRtextFieldEndEditing(_ textField: UITextField)
}

protocol KeyboardAvoidingScrollViewDelagate{
    func focusOnNextTextField()
}

public enum YRFieldType{
    case YRFieldTypeNone
    case YRFieldTypeRequired
    case YRFieldTypeEmailRequired
    case YRFieldTypeEmailNotRequired
    case YRFieldTypePassword
    case YRFieldTypePhoneNumberRequired
    case YRTextFieldTypePhoneNumberNotRequired
    case YRTextFieldTypeNumberOnly
    case YRTextFieldTypeName
    case YRTextFieldCvv
    case YRTextFieldTypeConfirmPassword
}

@IBDesignable public class YRTextField: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBInspectable @IBOutlet weak open var textField: UITextField!
    
    public let emptyString = ""
    public let emptyField = "required"
    
    var keyBoardAvoidingDelagate : KeyboardAvoidingScrollViewDelagate?
    var textFieldDelegate : YRTextFieldDelegate?
    public var textFieldTuple: (fieldType: YRFieldType,errorMsg :String) = (YRFieldType.YRFieldTypeNone,"")
    var view: UIView!
    var isValid = false
    // Use for password confirmation field
    public var confirmTextField : UITextField?=nil
    
    let validator = Validator()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        setDefault()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        setDefault()
    }
    
    func xibSetup() {
        let name = String(describing: type(of: self))
        let nib = UINib(nibName: name, bundle: Bundle(for: YRTextField.self))
        nib.instantiate(withOwner: self, options: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        
        self.textField.delegate = self
        self.textField.layer.borderColor = _borderColor.cgColor
        self.textField.layer.borderWidth = 1.0
        self.textField.layer.cornerRadius = 3.0
        self.textField.layer.masksToBounds = true
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        textField.leftView = paddingView
        textField.leftView?.isUserInteractionEnabled = false
        textField.leftViewMode = .always
        
        let paddingView2: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        textField.rightView = paddingView2
        textField.rightView?.isUserInteractionEnabled = false
        textField.rightViewMode = .always
        textField.keyboardType = UIKeyboardType.asciiCapable
        
        _ = validationLabel.text?.lowercased()
        self.textFieldHeightConstraint.constant = textFieldHeight
    }
    
    func setDefault(){
        self.textField.textColor = UIColor.black
    }
    
    @IBAction public func YRTextFieldEndEditing(_ sender: Any) {
        let textField = sender as! UITextField
        self.textField.layer.borderColor = UIColor.black.cgColor
        textField.text = textField.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        validateField(textField)
        textFieldDelegate?.YRtextFieldEndEditing(textField)
    }
    
    @IBAction public func YRTextFieldBeginEditing(_ sender: Any) {
        let textField = sender as! UITextField
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    @IBAction public func YRTextFieldEditingChanged(_ sender: Any) {
        let textField = sender as! UITextField
        if (textField.text == emptyString) {
        } else{
            validationLabel.text = emptyString
        }
        if textFieldTuple.fieldType == .YRTextFieldTypeName {
            self.textField.autocapitalizationType = .words
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch (textFieldTuple.fieldType) {
        case .YRTextFieldTypeName:
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        case .YRTextFieldTypeNumberOnly:
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        default:
            return true
        }
    }
    
    //MARK:- Customising the ui
    @IBInspectable var placeHolder: String = "" {
        didSet {
            self.textField.placeholder = placeHolder
        }
    }
    
    var text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    @IBInspectable var textFieldHeight: CGFloat = 40 {
        didSet {
            self.textFieldHeightConstraint.constant = textFieldHeight
        }
    }
    
    @IBInspectable var color: UIColor = UIColor.clear {
        didSet{
            self.validationLabel.textColor = color
        }
    }
    
    var _borderColor: UIColor = UIColor.black
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet{
            _borderColor = borderColor
            self.textField.layer.borderColor = _borderColor.cgColor
        }
    }
    
    @IBInspectable var invisibleBorder: Bool = false {
        didSet{
            if invisibleBorder {
                self.textField.layer.borderColor = UIColor.clear.cgColor
            }
            else{
                self.textField.layer.borderColor = _borderColor.cgColor
            }
        }
    }
    
    @IBInspectable var textAlignMentCenter: Bool = false {
        didSet{
            if textAlignMentCenter {
                self.textField.textAlignment = NSTextAlignment.left
            }
            else{
                self.textField.textAlignment = NSTextAlignment.center
            }
        }
    }
    
    func validateField(_ textField : UITextField){
        validator.validateField(textField){ error in
            if error == nil {
                // Field validation was successful
                self.isValid = true
                self.validationLabel.text = emptyString
                self.borderColor = UIColor.black
                if self.invisibleBorder{
                    self.textField.layer.borderColor = UIColor.clear.cgColor
                }
            } else {
                // Validation error occurred
                self.isValid = false
                error?.errorLabel?.text = error?.errorMessage
                error?.errorLabel?.textColor = UIColor.red
                self.borderColor = UIColor.blue
            }
        }
        if textField.text?.count == 0{
            return
        }
    }
    
    func isFieldValid() -> Bool{
        validateField(textField)
        return self.isValid
    }
    
    public var fieldTuple: (YRFieldType, String){
        get {
            return textFieldTuple
        }
        set(fieldTuple){
            textFieldTuple = fieldTuple
            switch(textFieldTuple.fieldType){
            case .YRFieldTypeEmailRequired:
                validator.registerField(textField, errorLabel: validationLabel, rules: [RequiredRule(), EmailRule(message: textFieldTuple.errorMsg)])
                textField.keyboardType = UIKeyboardType.emailAddress
                self.textField.autocapitalizationType = .none
                break
            case .YRFieldTypeEmailNotRequired:
                validator.registerField(textField, errorLabel: validationLabel, rules: [EmailRule(message: textFieldTuple.errorMsg)])
                textField.keyboardType = UIKeyboardType.emailAddress
                self.textField.autocapitalizationType = .none
                break
            case .YRFieldTypePassword:
                validator.registerField(textField, errorLabel: validationLabel, rules: [RequiredRule(), PasswordRule()])
                textField.isSecureTextEntry = true
                self.textField.autocapitalizationType = .none
                break
            case .YRFieldTypePhoneNumberRequired:
                validator.registerField(textField, errorLabel: validationLabel, rules: [RequiredRule(),  PhoneNumberRule()])
                textField.keyboardType = UIKeyboardType.phonePad
                self.textField.autocapitalizationType = .none
                break
            case .YRTextFieldTypePhoneNumberNotRequired:
                validator.registerField(textField, errorLabel: validationLabel, rules:  [PhoneNumberRule()])
                textField.keyboardType = UIKeyboardType.phonePad
                self.textField.autocapitalizationType = .none
                break
            case .YRTextFieldTypeNumberOnly:
                validator.registerField(textField, errorLabel: validationLabel, rules: [RequiredRule(), RegexRule(regex: "^[0-9]+$", message: textFieldTuple.errorMsg)])
                self.textField.keyboardType = UIKeyboardType.numberPad
                self.textField.autocapitalizationType = .none
                break
            case .YRTextFieldTypeName:
                validator.registerField(textField, errorLabel: validationLabel, rules: [RequiredRule(message: textFieldTuple.errorMsg), RegexRule(regex: "^([^0-9]*)", message: "No Numbers")])
                self.textField.keyboardType = UIKeyboardType.alphabet
                self.textField.autocapitalizationType = .words
                break
            case .YRTextFieldCvv:
                validator.registerField(textField, errorLabel: validationLabel, rules: [RequiredRule(), RegexRule(regex: "(^[0-9]{3}$)", message: textFieldTuple.errorMsg)])
                self.textField.keyboardType = UIKeyboardType.numberPad
                break
            case .YRTextFieldTypeConfirmPassword:
                validator.registerField(textField, errorLabel: validationLabel, rules: [RequiredRule( ), ConfirmationRule(confirmField: confirmTextField!, message: NSLocalizedString("passwords do not match", comment: ""))])
                textField.isSecureTextEntry = true
                self.textField.autocapitalizationType = .none
                break
            case .YRFieldTypeRequired:
                validator.registerField(textField, errorLabel: validationLabel, rules: [RequiredRule(message: textFieldTuple.errorMsg)])
                self.textField.autocapitalizationType = .words
                break
            case .YRFieldTypeNone:
                validator.registerField(textField, errorLabel: validationLabel, rules: [])
                self.textField.autocapitalizationType = .words
                break
            }
        }
    }
}

