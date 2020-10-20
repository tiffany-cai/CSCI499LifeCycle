//
//  SettingsViewController.swift
//  LifeCycle
//
//  Created by John Solano on 10/17/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func AccountTapped(_ sender: Any) {
        // Reference to Story Board
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let AccountVC = storyboard.instantiateViewController(identifier: "AccountViewController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(AccountVC)
        
        
    }
    
    @IBAction func NotificationsTapped(_ sender: Any) {
        // Reference to Story Board
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let NotificationVC = storyboard.instantiateViewController(identifier: "NotificationViewController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(NotificationVC)
    }
    
    @IBAction func SupportTapped(_ sender: Any) {
        // Reference to Story Board
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let SupportVC = storyboard.instantiateViewController(identifier: "SupportViewController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(SupportVC)
    }

}
