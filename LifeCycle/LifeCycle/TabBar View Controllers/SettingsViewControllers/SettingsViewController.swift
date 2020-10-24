//
//  SettingsViewController.swift
//  LifeCycle
//
//  Created by John Solano on 10/17/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var AccountBtn: UIButton!
    var userEmail : String = ""
    var userID : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set BG
        self.view.backgroundColor = UIColor.AppColors.AshGrey
        // Set Nav Bar Color
        
        
        // Get User ID/ Email
        let user = Auth.auth().currentUser
        if let user = user {
            userID = user.uid
            userEmail = user.email!
        }
        
        // Set account title as currently signed in users email
        AccountBtn.setTitle("     \(userEmail)                         ", for: .normal)
        
    }
    
    
    @IBAction func AccountTapped(_ sender: Any) {

    }
    
    @IBAction func NotificationsTapped(_ sender: Any) {

    }
    
    @IBAction func SupportTapped(_ sender: Any) {

    }

    

    
}
