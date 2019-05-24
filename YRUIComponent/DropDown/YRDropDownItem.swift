//
//  YRDropDownItem.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit
import Foundation

class YRDropDownItem: NSObject {
    var title: String?
    var image: UIImage?
    
    public init(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
}
