//
//  YRPopupView.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit

public class YRPopupView: UIView {

    var popUpContentView: UIView? = nil
    var doneButton: UIButton? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    
    lazy var popupBackgroundView: UIView = {
        let view  = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.backgroundColor = UIColor.black
        view.alpha = 0.3
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler(gesture:)))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    func viewSetup() {
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.addSubview(popupBackgroundView)
    }
    
    public func addPopUpContentView(contentView: UIView) {
        let centreX = UIScreen.main.bounds.width/2
        let centreY = UIScreen.main.bounds.height/2
        self.popUpContentView = contentView
        contentView.frame = CGRect(x: centreX - (contentView.frame.width/2), y: centreY - (contentView.frame.height/2) - 20, width: contentView.frame.width, height: contentView.frame.height)
        contentView.layer.cornerRadius = 15
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.8
        contentView.layer.shadowRadius = 5
        addSubview(contentView)
    }
    
    //MARK:- IBActions
    @objc func tapHandler(gesture: UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
    
    public func dismissTapped() {
        self.removeFromSuperview()
    }
}


