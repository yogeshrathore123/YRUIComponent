//
//  YRRadioButtonGroupView.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit

public class YRRadioButtonGroupView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    public lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 15, y: 0, width: Int(self.frame.width), height: 40)
        titleLabel.textColor = UIColor.black
        titleLabel.text = radioGroupTitle
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return titleLabel
    }()
    
    public lazy var subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.frame = CGRect(x: 15, y: 40, width: Int(self.frame.width), height: 20)
        subTitleLabel.textColor = UIColor.black
        subTitleLabel.text = radioGroupSubTitle
        subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        return subTitleLabel
    }()
    
    public lazy var titleView: UIView = {
        let titleView = UIView()
        titleView.backgroundColor = UIColor.white
        titleView.frame = CGRect(x: 0, y: 0, width: Int(self.frame.width), height: 60)
        titleView.addSubview(titleLabel)
        titleView.addSubview(subTitleLabel)
        return titleView
    }()
    
    public lazy var selectButton: UIButton = {
        let selectButton = UIButton()
        selectButton.frame = CGRect(x: self.frame.width - 75, y: 0, width: 75, height: 30)
        selectButton.setTitle("Select", for: .normal)
        selectButton.setTitleColor(UIColor.blue, for: .normal)
        selectButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        return selectButton
    }()
    
    public lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.frame = CGRect(x: self.frame.width - (selectButton.frame.width + 75), y: 0, width: 75, height: 30)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.red, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return cancelButton
    }()
    
    public lazy var toolBarView: UIView = {
        let toolBarView = UIView()
        toolBarView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 30)
        toolBarView.backgroundColor = UIColor.white
        toolBarView.addSubview(selectButton)
        toolBarView.addSubview(cancelButton)
        return toolBarView
    }()
    
    public var radioGroupTitle: String = "Pick Single Option" {
        didSet {
            titleLabel.text = "    " + radioGroupTitle
        }
    }
    
    public var radioGroupSubTitle: String = "Choose single item" {
        didSet {
            subTitleLabel.text = "    " + radioGroupSubTitle
        }
    }
    
    public var radioButtonTitleBackgroundColour: UIColor = UIColor.white {
        didSet {
            titleView.backgroundColor = radioButtonTitleBackgroundColour
        }
    }
    
    public var radioGroupViewBackgroundColour: UIColor = UIColor.white {
        didSet {
            radioGroupTableView?.backgroundColor = radioGroupViewBackgroundColour
            radioGroupTableView?.reloadData()
        }
    }
    
    public var radioGroupTitleTextColor: UIColor = UIColor.black {
        didSet {
            titleLabel.textColor = radioGroupTitleTextColor
        }
    }
    
    public var radioGroupSubTitleTextColor: UIColor = UIColor.black {
        didSet {
            subTitleLabel.textColor = radioGroupTitleTextColor
        }
    }
    
    public var radioButtonTextColour:UIColor = UIColor.black{
        didSet{
            radioGroupTableView?.reloadData()
        }
    }
    
    public var radioButtonColor: UIColor = UIColor.gray {
        didSet {
            radioGroupTableView?.reloadData()
        }
    }
    
    public var isPopupMode: Bool = true {
        didSet {
            if isPopupMode {
                addSubview(toolBarView)
            } else {
                toolBarView.removeFromSuperview()
            }
        }
    }
    
    public var items: [String] = [] {
        didSet {
            radioGroupTableView!.frame = CGRect(x: 0, y: 60, width: Int(self.frame.width), height: self.items.count * tableCellHeight)
            radioGroupTableView?.reloadData()
        }
    }
    
    var radioGroupTableView: UITableView? = nil
    public var selectedIndex: Int = -1
    public var onItemSelected: ((_ selectedIndex: Int) -> ())?
    let tableCellHeight = 50
    public var checkedRadioButtonImage: UIImage? = UIImage(named: "radio_checked", in: Bundle(for: YRRadioButtonGroupView.self), compatibleWith: nil)
    public var uncheckedRadioButtonImage: UIImage? = UIImage(named: "radio_unchecked", in: Bundle(for: YRRadioButtonGroupView.self), compatibleWith: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if frame == CGRect.zero {
            self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-20, height: 200)
        }
        viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    
    func viewSetup() {
        self.backgroundColor = UIColor.clear
        addSubview(titleView)
        setupRadioGroupTableView()
        addSubview(radioGroupTableView!)
    }
    
    func setupRadioGroupTableView() {
        radioGroupTableView = UITableView()
        radioGroupTableView?.frame = CGRect(x: 0, y: 60, width: Int(self.frame.width), height: self.items.count * tableCellHeight)
        radioGroupTableView?.delegate = self
        radioGroupTableView?.dataSource = self
        radioGroupTableView?.separatorStyle = .none
        radioGroupTableView?.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
    }
    
    //MARK:- UITableView delegate and data source methods
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        addRadioButton(cell: cell, index: indexPath.row)
        addRadioLabel(cell: cell, index: indexPath.row)
        cell.backgroundColor = radioGroupViewBackgroundColour
        cell.selectionStyle = .none
        return cell
    }
    
    func addRadioButton(cell: UITableViewCell, index: Int) {
        var radioButton = UIButton()
        if let button:UIButton = cell.viewWithTag(100) as? UIButton {
            radioButton = button
        }  else {
            radioButton.tag = 100
            radioButton.isUserInteractionEnabled = false
            radioButton.frame = CGRect(x: 20, y: 15, width: 20, height: 20)
            cell.addSubview(radioButton)
        }
        if index == selectedIndex {
            radioButton.setImage(checkedRadioButtonImage?.withRenderingMode(.alwaysTemplate), for: .normal)
            radioButton.imageView?.tintColor = radioButtonColor
        } else {
            radioButton.setImage(uncheckedRadioButtonImage?.withRenderingMode(.alwaysTemplate), for: .normal)
            radioButton.imageView?.tintColor = radioButtonColor
        }
    }
    
    func addRadioLabel(cell: UITableViewCell, index: Int) {
        var label = UILabel()
        if let textLabel: UILabel = cell.viewWithTag(101) as? UILabel {
            label = textLabel
        }  else {
            label.tag = 101
            label.frame = CGRect(x: 50, y: 0, width: (self.frame.width - 50), height: 50)
            label.text = items[index]
            label.textColor = radioButtonTextColour
            label.backgroundColor = UIColor.clear
            cell.addSubview(label)
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.radioGroupTableView?.reloadData()
        if !isPopupMode {
            if self.onItemSelected != nil {
                self.onItemSelected!(indexPath.row)
            }
        }
    }
    
    //MARK:- IBActions
    @objc func cancelButtonTapped() {
        (self.superview as! YRPopupView).dismissTapped()
    }
    
    @objc func selectButtonTapped() {
        if selectedIndex != -1 {
            if self.onItemSelected != nil {
                self.onItemSelected!(self.selectedIndex)
            }
            (self.superview as! YRPopupView).dismissTapped()
        }
    }
    
    override public func layoutSubviews() {
        if isPopupMode {
            toolBarView.frame = CGRect(x: 0, y: radioGroupTableView?.frame.maxY ?? 0, width: self.frame.width, height: 40)
        } else {
            toolBarView.frame = CGRect(x: 0, y: radioGroupTableView?.frame.maxY ?? 0, width: self.frame.width, height: 0)
        }
        
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: titleView.frame.height + (radioGroupTableView?.frame.height)! + toolBarView.frame.height)
    }
}

