//
//  RegisterViewController.swift
//  LifeCycle
//
//  Created by John Solano on 9/24/20.
//  Copyright © 2020 John Solano. All rights reserved.
//
import FirebaseFirestore
import UIKit
import Firebase

var ref : DatabaseReference?

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var fname : UITextField!
    @IBOutlet weak var lname : UITextField!
    @IBOutlet weak var email : UITextField!
    @IBOutlet weak var password : UITextField!
    @IBOutlet weak var repassword : UITextField!
    @IBOutlet weak var errorLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.barTintColor = SteelTeal
        self.view.backgroundColor = SteelTeal
        
        errorLabel.alpha = 0;
        
    }
    
    @IBAction func SignUpTapped(_ sender: Any) {
        // Clean fields from text box
        let Fname = fname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let Lname = lname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let Email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let Password = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let Repassword = repassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Reference to Story Board
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        
        //Register User
        Auth.auth().createUser(withEmail: Email, password: Password) { authResult, error in
            if let error = error {
                //Show error
                self.showError("\(error.localizedDescription)")
            }
            else {
                // add UUID to db
                guard let userID = Auth.auth().currentUser?.uid else { return }
                
                //add fname, lname to db
                // USING REALTIME DB
                ref = Database.database().reference()
                
                ref?.child("users").child(userID).setValue([
                    "Fname": Fname,
                    "Lname": Lname,
                    "Email": Email,
                    "Snooze": 15
                ]){
                      (error:Error?, ref:DatabaseReference) in
                      if let error = error {
                        print("Data could not be saved: \(error).")
                      } else {
                        print("Data saved successfully!")
                      }
                    }
                
                // Go to home page
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            }
        }
    }
    
    func showError(_ message:String){
     errorLabel.text = message
     errorLabel.alpha = 1
    }
    
    
 
    
}
