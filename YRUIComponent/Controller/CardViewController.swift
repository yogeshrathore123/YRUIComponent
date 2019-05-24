//
//  CardViewController.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit



class CardViewController: UIViewController {
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var sampleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.addCardView(cornerRadius: 5, shadowColor: UIColor.blue, shadowOffset: CGSize(width: 5, height: 4))
        sampleView.addCardView(cornerRadius: 5, shadowColor: UIColor.red, shadowOffset: CGSize(width: -4, height: 5))
    }
}
