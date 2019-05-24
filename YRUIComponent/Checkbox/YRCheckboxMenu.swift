//
//  YRCheckboxMenu.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit

class YRCheckboxMenu: UIView, UITableViewDelegate, UITableViewDataSource {
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 15, y: 0, width: Int(self.frame.width), height: 40)
        titleLabel.text = checkboxTitle
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return titleLabel
    }()
    
    lazy var subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.frame = CGRect(x: 15, y: 40, width: Int(self.frame.width), height: 20)
        subTitleLabel.text = checkboxSubTitle
        subTitleLabel.textColor = UIColor.black
        subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        return subTitleLabel
    }()
    
    lazy var titleView: UIView = {
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
    
    lazy var toolBarView: UIView = {
        let toolBarView = UIView()
        toolBarView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 30)
        toolBarView.backgroundColor = UIColor.white
        toolBarView.addSubview(selectButton)
        toolBarView.addSubview(cancelButton)
        return toolBarView
    }()
    
    public var checkboxTitle: String = "Pick Multiple Option" {
        didSet {
            titleLabel.text = checkboxTitle
        }
    }
    
    public var checkboxSubTitle: String = "Choose multiple items" {
        didSet {
            subTitleLabel.text = checkboxTitle
        }
    }
    
    public var checkboxTitleBackgroundColour: UIColor = UIColor.lightGray {
        didSet {
            titleView.backgroundColor = checkboxTitleBackgroundColour
        }
    }
    
    public var checkboxViewBackgroundColour: UIColor = UIColor.white {
        didSet {
            checkBoxTableView?.backgroundColor = checkboxViewBackgroundColour
            checkBoxTableView?.reloadData()
        }
    }
    
    public var checkboxTitleTextColor: UIColor = UIColor.black {
        didSet {
            titleLabel.textColor = checkboxTitleTextColor
        }
    }
    
    public var checkboxSubTitleTextColor: UIColor = UIColor.black {
        didSet {
            subTitleLabel.textColor = checkboxSubTitleTextColor
        }
    }
    
    public var checkboxItemTextColour:UIColor = UIColor.black{
        didSet{
            checkBoxTableView?.reloadData()
        }
    }
    
    public var checkboxColor: UIColor = UIColor.gray {
        didSet {
            checkBoxTableView?.reloadData()
        }
    }
    
    public var isPopupMode: Bool = false {
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
            checkBoxTableView!.frame = CGRect(x: 0, y: 60, width: Int(self.frame.width), height: self.items.count * tableCellHeight)
            checkBoxTableView?.reloadData()
        }
    }
    
    public var checkedImage: UIImage? = UIImage(named: "checkbox_checked", in: Bundle(for: YRCheckboxMenu.self), compatibleWith: nil)
    public var uncheckedImage: UIImage? = UIImage(named: "checkbox_unchecked", in: Bundle(for: YRCheckboxMenu.self), compatibleWith: nil)
    public var onItemsSelected: ((_ selectedIndexes: [Int]) -> ())?
    var checkBoxTableView: UITableView? = nil
    public var selectedIndexes: [Int] = []
    let tableCellHeight = 50
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if frame == CGRect.zero {
            self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 200)
        }
        viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    
    func viewSetup() {
        addSubview(titleView)
        setupCheckBoxTableView()
        addSubview(checkBoxTableView!)
    }
    
    func setupCheckBoxTableView() {
        checkBoxTableView = UITableView()
        checkBoxTableView?.frame = CGRect(x: 0, y: 60, width: Int(self.frame.width), height: self.items.count * tableCellHeight)
        checkBoxTableView?.delegate = self
        checkBoxTableView?.dataSource = self
        checkBoxTableView?.separatorStyle = .none
        checkBoxTableView?.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
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
        addCheckBoxButton(cell: cell, index: indexPath.row)
        addCheckBoxLabel(cell: cell, index: indexPath.row)
        cell.backgroundColor = checkboxViewBackgroundColour
        cell.selectionStyle = .none
        return cell
    }
    
    func addCheckBoxButton(cell: UITableViewCell, index: Int) {
        var checkBox = UIButton()
        if let button:UIButton = cell.viewWithTag(100) as? UIButton {
            checkBox = button
        }  else {
            checkBox.tag = 100
            checkBox.isUserInteractionEnabled = false
            checkBox.frame = CGRect(x: 20, y: 15, width: 25, height: 25)
            cell.addSubview(checkBox)
        }
        if selectedIndexes.contains(index) {
            checkBox.setImage(checkedImage?.withRenderingMode(.alwaysTemplate), for: .normal)
            checkBox.imageView?.tintColor = checkboxColor
        } else {
            checkBox.setImage(uncheckedImage?.withRenderingMode(.alwaysTemplate), for: .normal)
            checkBox.imageView?.tintColor = checkboxColor
        }
    }
    
    func addCheckBoxLabel(cell: UITableViewCell, index: Int) {
        var label = UILabel()
        if let textLabel: UILabel = cell.viewWithTag(101) as? UILabel {
            label = textLabel
        }  else {
            label.tag = 101
            label.frame = CGRect(x: 60, y: 0, width: (self.frame.width - 60), height: 50)
            label.text = items[index]
            label.backgroundColor = UIColor.clear
            label.textColor = checkboxItemTextColour
            cell.addSubview(label)
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexes.contains(indexPath.row) {
            if let index = selectedIndexes.firstIndex(of: indexPath.row) {
                selectedIndexes.remove(at: index)
            }
        } else {
            selectedIndexes.append(indexPath.row)
        }
        self.checkBoxTableView?.reloadData()
    }
    
    //MARK:- IBActions
    @objc func cancelButtonTapped() {
        (self.superview as! YRPopupView).dismissTapped()
    }
    
    @objc func selectButtonTapped() {
        if isPopupMode {
            if selectedIndexes.count != 0 {
                if self.onItemsSelected != nil {
                    self.onItemsSelected!(selectedIndexes)
                }
                (self.superview as! YRPopupView).dismissTapped()
            }
        }
    }
    
    override public func layoutSubviews() {
        if isPopupMode {
            toolBarView.frame = CGRect(x: 0, y: checkBoxTableView?.frame.maxY ?? 0, width: self.frame.width, height: 40)
        } else {
            toolBarView.frame = CGRect(x: 0, y: checkBoxTableView?.frame.maxY ?? 0, width: self.frame.width, height: 0)
        }
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: titleView.frame.height + checkBoxTableView!.frame.height + toolBarView.frame.height)
    }
}



