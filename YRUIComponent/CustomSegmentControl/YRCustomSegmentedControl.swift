//
//  YRCustomSegmentedControl.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit

@IBDesignable public class YRCustomSegmentedControl: UIControl {

    var buttons = [UIButton]()
    var underLiner: UIView!
    var selector: UIView!
    
    public var isUnderLinerNeeded: Bool = false {
        didSet{
            updateView()
        }
    }
    
    public var selectedSegmentIndex = 0 {
        didSet {
            updateSegmentedControlSegs(index: selectedSegmentIndex)
        }
    }
    public var numberOfSegments: Int = 0 {
        didSet {
            numberOfSegments = buttons.count
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable public var commaSeperatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    @IBInspectable public var textColor: UIColor = .red {
        didSet {
            updateView()
        }
    }
    @IBInspectable public var selectorColor: UIColor = .blue {
        didSet {
            updateView()
        }
    }
    @IBInspectable public var selectorTextColor: UIColor = .blue {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var underLinerColor: UIColor = .red {
        didSet {
            updateView()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Function to update tab segmented view
    func updateView() {
        buttons.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        let buttonTitles = commaSeperatedButtonTitles.components(separatedBy: ",")
        for buttonTitle in buttonTitles {
            let button = UIButton.init(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = UIFont.init(name: "System-Bold", size: 18)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
            // button.setTitleColor(button.isSelected ? UIColor.gray : selectorTextColor, for: .normal)
        }
        numberOfSegments = buttons.count
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        // For UnderLiner For SegmentedController
        if isUnderLinerNeeded {
            underLiner = UIView.init()
            underLiner.backgroundColor = underLinerColor
            addSubview(underLiner)
            underLiner.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                underLiner.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
                underLiner.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
                underLiner.heightAnchor.constraint(equalToConstant: 2.0),
                underLiner.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -2.0)
                ])
        }
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        let y = ((self.frame.maxY - self.frame.minY) - 3.0)
        selector = UIView.init(frame: CGRect.init(x: 0, y: y, width: selectorWidth, height: 3.0))
        // selector.layer.cornerRadius = frame.height/2
        selector.backgroundColor = selectorColor
        addSubview(selector)
        // Create a StackView
        let stackView = UIStackView.init(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0.0
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    @objc func buttonTapped(button: UIButton) {
        var selectorStartPosition: CGFloat!
        for (buttonIndex,btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == button {
                selectedSegmentIndex = buttonIndex
                selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3, animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                })
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }
    
    /// Function to update segmented control
    ///
    /// - Parameter index: selected index
    func updateSegmentedControlSegs(index: Int) {
        var selectorStartPosition: CGFloat!
        for btn in buttons {
            btn.setTitleColor(textColor, for: .normal)
        }
        selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(index)
        UIView.animate(withDuration: 0.3, animations: {
            self.selector.frame.origin.x = selectorStartPosition
        })
        buttons[index].setTitleColor(selectorTextColor, for: .normal)
    }
    
    override public func sendActions(for controlEvents: UIControl.Event) {
        super.sendActions(for: controlEvents)
        var selectorStartPosition: CGFloat!
        selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.3, animations: {
            self.selector.frame.origin.x = selectorStartPosition
        })
        buttons[selectedSegmentIndex].setTitleColor(selectorTextColor, for: .normal)
    }


}
