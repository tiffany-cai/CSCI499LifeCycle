//
//  NotificationViewController.swift
//  LifeCycle
//
//  Created by John Solano on 10/19/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    /*
     
     End Dates from logged in users item table
     
     Controling phones sound/vibrations
     
     changing snooze time
     
     */
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set BG
        self.view.backgroundColor = UIColor.AppColors.AshGrey
        
    }
    

    @IBAction func BackBtn(_ sender: Any) {
        print("tapped")
             //(UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        
        // Return to Setting Page
       
        
        //tabBarController.selectedIndex = 3
        //let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        //(UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")
        
        
        //let tabBarController = UITabBarController()
        //tabBarController.viewControllers = [settingsVC]
        

        
        
    }

}
