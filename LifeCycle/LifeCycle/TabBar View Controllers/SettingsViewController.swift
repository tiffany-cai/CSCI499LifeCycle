//
//  SettingsViewController.swift
//  LifeCycle
//
//  Created by John Solano on 10/8/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    @IBOutlet weak var test: UITextField!
    
    @IBOutlet weak var settings: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       // settings.setPadding()
        //settings.setBottomBorder()
    }
    
}
/*extension UILabel {
   /* func setPadding() {
        let paddingview = UIView(frame:CGRect(x: 0,y: 0, width:10, height: self.frame.height))
        self.leftView = paddingview
        self.leftViewMode = .always
    }*/
    
    func setBottomBorder() {
        self.layer.shadowColor = UIColor.red.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}*/
