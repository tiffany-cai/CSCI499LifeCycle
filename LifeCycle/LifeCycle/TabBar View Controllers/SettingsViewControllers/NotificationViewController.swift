//
//  NotificationViewController.swift
//  LifeCycle
//
//  Created by John Solano on 10/19/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    @IBOutlet weak var quarter: UIButton!
    @IBOutlet weak var half: UIButton!
    @IBOutlet weak var full: UIButton!
    @IBOutlet weak var none: UIButton!
    
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
    
    @IBAction func quarterAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            half.isSelected = false
            full.isSelected = false
            none.isSelected = false
        }
        else {
            sender.isSelected = true
            half.isSelected = false
            full.isSelected = false
            none.isSelected = false
        }
    }
    
    @IBAction func halfAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            half.isSelected = false
            full.isSelected = false
            none.isSelected = false
        }
        else {
            sender.isSelected = true
            quarter.isSelected = false
            full.isSelected = false
            none.isSelected = false
        }
    }
    @IBAction func fullAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            quarter.isSelected = false
            half.isSelected = false
            none.isSelected = false
        }
        else {
            sender.isSelected = true
            quarter.isSelected = false
            half.isSelected = false
            none.isSelected = false
        }
    }
    
    @IBAction func noneAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            quarter.isSelected = false
            half.isSelected = false
            full.isSelected = false
        }
        else {
            sender.isSelected = true
            quarter.isSelected = false
            half.isSelected = false
            full.isSelected = false
        }
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let SettingsVC = storyboard.instantiateViewController(identifier: "SettingsViewController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(SettingsVC)
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
