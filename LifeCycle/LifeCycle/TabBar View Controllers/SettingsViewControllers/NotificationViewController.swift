//
//  NotificationViewController.swift
//  LifeCycle
//
//  Created by John Solano on 10/19/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set BG
        self.view.backgroundColor = UIColor.AppColors.AshGrey
    }
    

    @IBAction func BackBtn(_ sender: Any) {
        // Return to Setting Page
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let SettingsVC = storyboard.instantiateViewController(identifier: "SettingsViewController")
         (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(SettingsVC)
    }

}
