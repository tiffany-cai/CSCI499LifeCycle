//
//  ListViewController.swift
//  LifeCycle
//
//  Created by John Solano on 10/10/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit
import Firebase

class ListViewController: UIViewController {

    var userID : String = ""
    var email : String = ""
    
    @IBOutlet weak var UUIDLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = Auth.auth().currentUser
        if let user = user {
            userID = user.uid
            email = user.email!
        }
            
        UUIDLabel.text = "UUID: \(userID)"
        EmailLabel.text = "Email: \(email)"
    }

}

