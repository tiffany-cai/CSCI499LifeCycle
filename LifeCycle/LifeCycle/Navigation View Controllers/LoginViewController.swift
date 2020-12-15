//
//  LoginViewController.swift
//  LifeCycle
//
//  Created by John Solano on 9/22/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit


class LoginViewController: UIViewController {

    
    @IBOutlet weak var username : UITextField!
    
    @IBOutlet weak var password : UITextField!
    
    @IBOutlet weak var errorLabel : UILabel!
    @IBOutlet weak var fblogin: UIButton!
    
    @IBOutlet weak var showpass: UIButton!
    
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = SteelTeal
        self.view.backgroundColor = SteelTeal

        errorLabel.alpha = 0;
      //  let loginButton = FBLoginButton()
       // loginButton.center = view.center
       // view.addSubview(loginButton)
 
    }
    
    @IBAction func fbLogin(_ sender: Any) {
       // FBLoginButton()
        //loginButton.center = view.center
       // view.addSubview(loginButton)
        fblogin.addTarget(self, action: #selector(handleFBLogin), for: .touchUpInside)

    }
    @objc func handleFBLogin() {
        LoginManager().logIn( permissions: ["email","public_profile"])
        
        
        showEmailAddress()
   // let storyboard = UIStoryboard(name: "Main", bundle: nil)
   // let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
   // (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        guard let userID = Auth.auth().currentUser?.uid else { return }
        

        // USING REALTIME DB
        ref = Database.database().reference()

        ref?.child("users").child(userID).updateChildValues([

            :])
    }
    func showEmailAddress() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        let accessToken = AccessToken.current
        guard let accessTokenString = accessToken?.tokenString else { return }
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credentials, completion: { ( user, error) in
            if error != nil {
                print("something went wrong with our fb user: ", error)
            }
            print ("success",user)

                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            guard let userID = Auth.auth().currentUser?.uid else { return }
            
            //add fname, lname to db
            // USING REALTIME DB
            ref = Database.database().reference()
            ref?.child("users").child(userID).updateChildValues([
                "Snooze": 15
            ])
        })
        GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            if err != nil {
                print ("failed to start", err)
                return
            }
            print (result)
            
            
        }
    }
    @IBAction func LoginTapped(_ sender: Any) {
        //for debugging
        print("Login Tapped");
        
        // Create clean fields/parse text from text box
        let email = username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Reference to Story Board
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        
        //Sign in the user
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error {
                self.showError("\(error.localizedDescription)")
            }
            else{
                // This is to get the SceneDelegate object from your view controller
                // then call the change root view controller function to change to main tab bar
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            }
        } // end of sign in
        
    }

    
    func showError(_ message:String){
     errorLabel.text = message
     errorLabel.alpha = 1
    }

    
    @IBAction func showpass(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            password.isSecureTextEntry = true
        }
        else {
            sender.isSelected = true
            password.isSecureTextEntry = false
            
        }
    }
    
    
    @IBAction func DebugTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        
        Auth.auth().signIn(withEmail: "test@testing.com", password: "LifeCycle")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
    
}
