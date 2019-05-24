//
//  YRMenuViewController.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int)
}

class YRMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var closeMenuButton: UIButton? = nil
    var menuTableView: UITableView? = nil
    var menuButton : UIButton!
    var delegate : SlideMenuDelegate?
    var menuItems: [String] = []
    
    var backgroundColor: UIColor = UIColor.cyan {
        didSet {
            self.menuTableView?.backgroundColor = backgroundColor
            self.menuTableView?.reloadData()
        }
    }
    
    var menuTextColor: UIColor = UIColor.black {
        didSet {
            self.menuTableView?.reloadData()
        }
    }
    
    var menuItemSelectionColor: UIColor = UIColor.lightText {
        didSet {
            self.menuTableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupMenu() {
        closeMenuButton = UIButton()
        closeMenuButton?.frame = self.view.frame
        closeMenuButton?.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(closeMenuButton!)
        menuTableView = UITableView()
        menuTableView?.delegate = self
        menuTableView?.dataSource = self
        menuTableView?.separatorStyle = .none
        menuTableView?.backgroundColor = backgroundColor
        self.view.addSubview(menuTableView!)
    }
    
    func createMenu(items: [String]) {
        self.menuItems = items
        setupMenu()
        menuTableView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.8, height: self.view.frame.height)
        menuTableView?.reloadData()
    }
    
    @objc func closeButtonTapped(_ sender: UIButton) {
        menuButton.tag = 0
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion : { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = menuTextColor
        cell.backgroundColor = backgroundColor
        let backgroundView = UIView()
        backgroundView.backgroundColor = menuItemSelectionColor
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.slideMenuItemSelectedAtIndex(indexPath.row)
    }
}
