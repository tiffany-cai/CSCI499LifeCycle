//
//  LoginViewController.swift
//  LifeCycle
//
//  Created by John Solano on 9/22/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func EmailTextField(_ sender: UITextField) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    @IBAction func LoginTapped(_ sender: Any) {
        //for debugging
        print("Login Tapped");
        
        
        // Switch root controller to Tab BAr
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
