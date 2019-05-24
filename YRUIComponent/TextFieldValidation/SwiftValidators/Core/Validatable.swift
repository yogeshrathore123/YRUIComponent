//
//  Validatable.swift
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import Foundation
import UIKit

public typealias ValidatableField = AnyObject & Validatable

public protocol Validatable {
    
    var validationText: String {
        get
    }
}

extension UITextField: Validatable {
    
    public var validationText: String {
        return text ?? ""
    }
}
