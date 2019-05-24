//
//  YRParallaxTableHeaderViewController.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit

open class YRParallaxTableHeaderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    var contentTableView: UITableView? = nil
    var parallaxImageView: UIImageView? = nil
    var labeltext: UILabel? = nil
    var labelContainerView: UIView? = nil
    
    public var parallaxImage: UIImage? = UIImage(named: "background") {
        didSet {
            parallaxImageView?.image = parallaxImage
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        setupImageview(image: parallaxImage)
    }
    
    func setupTableview() {
        contentTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        contentTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        contentTableView?.dataSource = self
        contentTableView?.delegate = self
        contentTableView?.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
        if contentTableView != nil  {
            self.view.addSubview(contentTableView!)
        }
    }
    
    func setupImageview(image: UIImage?) {
        parallaxImageView = UIImageView()
        parallaxImageView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
        parallaxImageView?.image = image
        parallaxImageView?.contentMode = .scaleAspectFill
        parallaxImageView?.clipsToBounds = true
        if parallaxImageView != nil {
            view.addSubview(parallaxImageView!)
        }
    }
    
    //set the label view with required parameter
    //required parameters:
    //text
    //optional parameters:
    //textColor, font, titleBackgroundColor, headerAlpha
    open func setupLabelview(text: String, textColor: UIColor = UIColor.white, font: UIFont? = UIFont(name: "Helvetica", size: 24.0), titleBackgroundColor: UIColor = UIColor.black, headerAlpha: CGFloat = 0.6) {
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        labelContainerView = UIView()
        labelContainerView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100 + topBarHeight)
        labelContainerView?.backgroundColor = titleBackgroundColor
        labelContainerView?.alpha = headerAlpha
        labeltext = UILabel()
        labeltext?.frame = CGRect(x: 30, y: labelContainerView!.frame.height - 60 , width: UIScreen.main.bounds.size.width, height: 60)
        labeltext?.text = text
        labeltext?.font = font
        labeltext?.textColor = textColor
        labelContainerView?.addSubview(labeltext!)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 100), 400)
        parallaxImageView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        var minHeaderHeight = 110
        if topBarHeight > UIApplication.shared.statusBarFrame.size.height {
            minHeaderHeight = 160
        }
        if(Int(height) < minHeaderHeight)
        {
            parallaxImageView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100 + topBarHeight)
            contentTableView?.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
            if labelContainerView != nil {
                view.addSubview(labelContainerView!)
            }
        } else if height > 250 {
            contentTableView?.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
            labelContainerView?.removeFromSuperview()
        }
    }
    
    //MARK:- Tableview data source and delegate methods
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "Hello"
        return cell
    }
}
