//
//  YRDropDownView.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit

public class YRDropDownView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    public enum DropDownMode {
        case TopDown
        case BottomUp
    }
    
    public var dropDownMode: DropDownMode = .TopDown
    {
        didSet {
            setFrames()
        }
    }
    
    lazy var dropDownButton: UIButton = {
        let dropDownButton = UIButton()
        dropDownButton.setTitle(dropDownTitle, for: .normal)
        dropDownButton.semanticContentAttribute = .forceRightToLeft
        dropDownButton.imageView?.contentMode = .scaleAspectFit
        dropDownButton.imageEdgeInsets = UIEdgeInsets(top: 15.0, left: 0, bottom: 15.0, right: -(self.frame.height/2))
        dropDownButton.contentHorizontalAlignment = .center
        dropDownButton.backgroundColor = dropDownTitleBackgroundColour
        dropDownButton.setTitleColor(dropDownTitleTextColor, for: .normal)
        dropDownButton.addTarget(self, action: #selector(dropDownClicked(sender:)), for: .touchUpInside)
        return dropDownButton
    }()
    
    public var dropDownTitleBackgroundColour: UIColor = UIColor.white {
        didSet {
            dropDownButton.backgroundColor = dropDownTitleBackgroundColour
        }
    }
    
    public var dropDownViewBackgroundColour: UIColor = UIColor.white {
        didSet {
            dropDownTableView?.backgroundColor = dropDownViewBackgroundColour
            dropDownTableView?.reloadData()
        }
    }
    
    public var dropDownTitle: String = "Select item" {
        didSet {
            dropDownButton.setTitle(dropDownTitle, for: .normal)
        }
    }
    
    public var dropDownTitleTextColor: UIColor = UIColor.black {
        didSet {
            dropDownButton.setTitleColor(dropDownTitleTextColor, for: .normal)
        }
    }
    
    public var dropDownItemTextColour: UIColor = UIColor.black {
        didSet {
            dropDownTableView?.reloadData()
        }
    }
    
    public var dropDownViewBorderColor: UIColor = UIColor.black {
        didSet {
            dropDownTableView?.layer.borderColor = dropDownViewBorderColor.cgColor
        }
    }
    
    public var dropDownViewBorderWidth: Int = 2 {
        didSet {
            dropDownTableView?.layer.borderWidth = CGFloat(dropDownViewBorderWidth)
        }
    }
    
    var items: [YRDropDownItem] = [] {
        didSet {
            dropDownTableView?.reloadData()
        }
    }
    
    public var upArrowImage: UIImage = UIImage(named: "uparrow", in: Bundle(for: YRDropDownView.self), compatibleWith: nil)!
    public var downArrowImage: UIImage = UIImage(named: "downarrow", in: Bundle(for: YRDropDownView.self), compatibleWith: nil)!
    public var onItemSelected: ((_ selectedIndex: Int) -> ())?
    var dropDownTableView: UITableView? = nil
    let tableCellHeight = 50
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if frame == CGRect.zero {
            self.frame = CGRect(x: 0, y: 0, width: 240, height: 200)
        }
        viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    
    func viewSetup() {
        addSubview(dropDownButton)
        setupDropDownTableView()
        addSubview(dropDownTableView!)
    }
    
    func setupDropDownTableView() {
        dropDownTableView = UITableView()
        dropDownTableView?.delegate = self
        dropDownTableView?.dataSource = self
        dropDownTableView?.layer.borderColor = dropDownViewBorderColor.cgColor
        dropDownTableView?.layer.borderWidth = CGFloat(dropDownViewBorderWidth)
        dropDownTableView?.separatorStyle = .none
        dropDownTableView?.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
        dropDownTableView?.isHidden = true
    }
    
    func setFrames() {
        var tableHeight = 0
        var bottomUpFrameMinY: CGFloat = (self.frame.maxY - dropDownButton.frame.height)
        if !dropDownTableView!.isHidden {
            tableHeight = items.count * tableCellHeight
            bottomUpFrameMinY = self.frame.maxY - dropDownButton.frame.height - CGFloat(tableHeight)
        }
        if self.dropDownMode == .TopDown {
            if dropDownTableView!.isHidden {
                dropDownButton.setImage(downArrowImage, for: .normal)
            }else {
                dropDownButton.setImage(upArrowImage, for: .normal)
            }
            dropDownButton.frame = CGRect(x: 0, y: 0, width: Int(self.frame.width), height: 50)
            dropDownTableView?.frame = CGRect(x: 0, y: 50, width: Int(self.frame.width), height: tableHeight)
            self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: dropDownButton.frame.height + (dropDownTableView?.frame.height)!)
        } else {
            if dropDownTableView!.isHidden {
                dropDownButton.setImage(upArrowImage, for: .normal)
            }else {
                dropDownButton.setImage(downArrowImage, for: .normal)
            }
            dropDownButton.frame = CGRect(x: 0, y: tableHeight, width: Int(self.frame.width), height: 50)
            dropDownTableView?.frame = CGRect(x: 0, y: 0, width: Int(self.frame.width), height: tableHeight)
            self.frame = CGRect(x: self.frame.minX, y: bottomUpFrameMinY, width: self.frame.width, height: dropDownButton.frame.height + (dropDownTableView?.frame.height)!)
        }
    }
    
    //MARK:- UITableView delegate and datasource methods
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        cell.textLabel?.text = items[indexPath.row].title
        cell.imageView?.image = items[indexPath.row].image
        let itemSize = CGSize.init(width: cell.frame.height/2, height: cell.frame.height/2)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale);
        let imageRect = CGRect.init(origin: CGPoint.zero, size: itemSize)
        cell?.imageView?.image?.draw(in: imageRect)
        cell?.imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        cell.textLabel?.textColor = self.dropDownItemTextColour
        cell.backgroundColor = self.dropDownViewBackgroundColour
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dropDownButton.setTitle(items[indexPath.row].title, for: .normal)
        dropDownTableView?.isHidden = true
        setFrames()
        if self.onItemSelected != nil {
            self.onItemSelected!(indexPath.row)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    //MARK:- IBActions
    @objc func dropDownClicked(sender: UIButton) {
        dropDownTableView!.isHidden = !dropDownTableView!.isHidden
        setFrames()
    }
    
    override public func layoutSubviews() {
        setFrames()
        self.superview?.layoutSubviews()
    }
}
