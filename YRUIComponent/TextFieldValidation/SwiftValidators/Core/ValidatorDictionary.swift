//
//  ValidatorDictionary.swift
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import Foundation

public struct ValidatorDictionary<T> : Sequence {
    
    private var innerDictionary: [ObjectIdentifier: T] = [:];
    
    public subscript(key: ValidatableField?) -> T? {
        get {
            if let key = key {
                return innerDictionary[ObjectIdentifier(key)];
            } else {
                return nil;
            }
        }
        set(newValue) {
            if let key = key {
                innerDictionary[ObjectIdentifier(key)] = newValue;
            }
        }
    }
    
    public mutating func removeAll() {
        innerDictionary.removeAll()        
    }
    
    public mutating func removeValueForKey(_ key: ValidatableField) {
        innerDictionary.removeValue(forKey: ObjectIdentifier(key))
    }
    
    public var isEmpty: Bool {
        return innerDictionary.isEmpty
    }
    
    public func makeIterator() -> DictionaryIterator<ObjectIdentifier ,T> {
        return innerDictionary.makeIterator()
    }
}
