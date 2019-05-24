//
//  CollectionViewController.swift
//  YRUIComponent
//
//  Created by Yogesh Rathore on 24/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController ,UICollectionViewDataSource ,UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    let images = ["add-image","dropdown","fingerprint","calendar","menu","checkbox","radio-button","parallaxTableHeader","star","notifications-bell-button", "form_icon", "card_icon", "contacts_icon", "qr_code", "ocr_image","document-scanning","document-scanning","card_icon", "card_icon", "add-image"
    ]
    let label = ["Dropdown","Date Time Picker"
        ,"Slide-In Menu","CheckBox","Radio Button","Parallax Table Header","Rating Bar", "Text Field Validation", "CardView", "Segmented Tab Control"
    ]
    let storyBoardIdentifiers = ["DropDownViewController", "DateTimePickerViewController", "SlideMenuViewController", "CheckBoxViewController", "RadioButtonViewController", "ParallaxViewController", "RatingBarViewController", "TextFieldValidationViewController", "CardViewController", "TabSegmentedViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        //        self.collectionView.backgroundColor = UIColor.orange
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        layout.itemSize = CGSize(width: (collectionView.frame.width/2) - 50, height: collectionView.frame.width/2 - 50)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        collectionView!.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return label.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
//        cell.imageView.image = UIImage(named: images[indexPath.row])!.withRenderingMode(.alwaysTemplate)
//        cell.imageView.tintColor = self.view.tintColor
        cell.label.text = label[indexPath.row]
        //This creates the shadows and modifies the cards a little bit
        cell.layer.cornerRadius = 10.0
        cell.layer.borderWidth = 0.5
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize(width: -2, height: 5)
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 10).cgPath
        cell.layer.shadowColor=UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            pushController(identifier: storyBoardIdentifiers[indexPath.row])
      
    }
    
    func notifyUser(_ title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: {
                                            action in
                                            self.collectionView.isHidden = false
        })
        alert.addAction(cancelAction)
        self.present(alert, animated: true,
                     completion: nil)
    }
    
}

extension UIViewController
{
    func pushController(identifier : String)
    {
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: identifier) {
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}



