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
        /*
        // Reference to Story Board
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let AccountVC = storyboard.instantiateViewController(identifier: "AccountViewController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(AccountVC)
        
        */
    }
    
    @IBAction func NotificationsTapped(_ sender: Any) {
        /*
        // Reference to Story Board
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let NotificationVC = storyboard.instantiateViewController(identifier: "NotificationViewController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(NotificationVC)
 
 */
    }
    
    @IBAction func SupportTapped(_ sender: Any) {
        /*
        // Reference to Story Board
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let SupportVC = storyboard.instantiateViewController(identifier: "SupportViewController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(SupportVC)
 */
    }

}
