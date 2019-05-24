//
//  YRCardView.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit

extension UIView {
    public func addCardView(cornerRadius: CGFloat, shadowColor: UIColor, shadowOffset: CGSize) {
        layer.cornerRadius = cornerRadius
        //        backgroundColor = UIColor.white
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = shadowOffset
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = 0.5
    }
}
