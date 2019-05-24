//
//  Validation.swift
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import Foundation

/**
 The `Rule` protocol declares the required methods for all objects that subscribe to it.
 */
public protocol Rule {
    /**
     Validates text of a field.
     
     - parameter value: String of text to be validated.
     - returns: Boolean value. True if validation is successful; False if validation fails.
     */
    func validate(_ value: String) -> Bool
    /**
     Displays error message of a field that has failed validation.
     
     - returns: String of error message.
     */
    func errorMessage() -> String
}
