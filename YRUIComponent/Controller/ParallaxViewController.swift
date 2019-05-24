//
//  ParallaxViewController.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit


class ParallaxViewController: YRParallaxTableHeaderViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        parallaxImage = UIImage(named: "background")
        setupLabelview(text: "Profile Name", textColor: .white, font: UIFont(name: "Helvetica", size: 24.0))
        //        or
        //        setupLabelview(text: "Pro",  titleBackgroundColor: UIColor.black, headerAlpha: 0.7)
        //        or
        //        setupLabelview(text: "Profile Name", textColor: .white, font: UIFont(name: "Helvetica", size: 24.0), titleBackgroundColor: .black, headerAlpha: 0.6)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

}
