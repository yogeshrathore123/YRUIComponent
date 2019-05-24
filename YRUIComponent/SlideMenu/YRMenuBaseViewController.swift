//
//  YRMenuBaseViewController.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit

class YRMenuBaseViewController: UIViewController, SlideMenuDelegate {
    
    public var menuBackgroundColor: UIColor = UIColor.cyan
    public var menuItemTextColor: UIColor = UIColor.black
    public var menuItemSelectionColor: UIColor = UIColor.lightText
    public var menuItems: [String] = []
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    open func slideMenuItemSelectedAtIndex(_ index: Int) {
    }
    
    public func addSlideMenuButton(menuButtonImage: UIImage?, items: [String]){
        let menuButton = UIButton(type: UIButton.ButtonType.system)
        if menuButtonImage != nil {
            menuButton.setImage(menuButtonImage, for: .normal)
        } else {
            menuButton.setImage(self.defaultMenuImage(), for: .normal)
        }
        menuButton.imageView?.contentMode = .scaleAspectFit
        menuButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        menuButton.addTarget(self, action: #selector(YRMenuBaseViewController.onSlideMenuButtonPressed(_:)), for: UIControl.Event.touchUpInside)
        let customBarItem = UIBarButtonItem(customView: menuButton)
        self.navigationItem.leftBarButtonItem = customBarItem;
        self.menuItems  = items
    }
    
    func defaultMenuImage() -> UIImage {
        var defaultMenuImage = UIImage()
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
        UIColor.black.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
        UIColor.white.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()
        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return defaultMenuImage;
    }
    
    //MARK:- IBActions
    @objc func onSlideMenuButtonPressed(_ sender : UIButton){
        if (sender.tag == 10) {
            // To Hide Menu If it already there
            sender.tag = 0;
            hideMenu()
            return
        } else {
            sender.isEnabled = false
            sender.tag = 10
            showMenu(menuButton: sender)
        }
    }
    
    func hideMenu() {
        let viewMenuBack : UIView = view.subviews.last!
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            var frameMenu : CGRect = viewMenuBack.frame
            frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
            viewMenuBack.frame = frameMenu
            viewMenuBack.layoutIfNeeded()
            viewMenuBack.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            viewMenuBack.removeFromSuperview()
        })
    }
    
    func showMenu(menuButton: UIButton) {
        let menuVC = YRMenuViewController()
        menuVC.menuButton = menuButton
        menuVC.delegate = self
        menuVC.backgroundColor = menuBackgroundColor
        menuVC.menuTextColor = menuItemTextColor
        menuVC.menuItemSelectionColor = menuItemSelectionColor
        menuVC.createMenu(items: menuItems)
        self.view.addSubview(menuVC.view)
        self.addChild(menuVC)
        menuVC.view.layoutIfNeeded()
        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            menuButton.isEnabled = true
        }, completion:nil)
    }
}
