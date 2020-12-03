//
//  AccountViewController.swift
//  LifeCycle
//
//  Created by John Solano on 10/19/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    @IBOutlet weak var CurEM: UITextField!
    @IBOutlet weak var NewEM: UITextField!
    @IBOutlet weak var NewPass: UITextField!
    @IBOutlet weak var ReNewPass: UITextField!
    @IBOutlet weak var EmErrLbl: UILabel!
    @IBOutlet weak var PassErrLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set BG
        self.view.backgroundColor = UIColor.AppColors.AshGrey
        // Config Error Labels
        EmErrLbl.alpha = 0;
        PassErrLbl.alpha = 0;
    }
    
    
    @IBAction func ChangeEMbtn(_ sender: Any) {
        let userEmail = Auth.auth().currentUser?.email
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        // Check if current email matches email on DB
        // Check if New Email text field isnt empty
        if CurEM.text == userEmail! && NewEM.text != nil {
            Auth.auth().currentUser?.updateEmail(to: NewEM.text!){ (error) in
                if let error = error {
                    self.showEmError("\(error.localizedDescription)")
                }
                else {
                    // Change Email variable in the realtime DB
                    ref?.child("users").child(userID).updateChildValues(["Email" : self.NewEM.text!])
                    
                    // reset text fields
                    self.CurEM.text = ""
                    self.NewEM.text = ""
                
                    // show success label
                    self.EmErrLbl.text = "Success"
                    self.EmErrLbl.backgroundColor = UIColor.green
                    self.EmErrLbl.alpha = 1
                }
            
            }
        }
    }
    
    func showEmError(_ message:String){
     EmErrLbl.text = message
     EmErrLbl.alpha = 1
    }
        
    
    @IBAction func ChangePassbtn(_ sender: Any) {
        // If Passwords match
        if NewPass.text! == ReNewPass.text! {
            // Change password
            Auth.auth().currentUser?.updatePassword(to: NewPass.text!) { (error) in
                if let error = error {
                    self.showPassError("\(error.localizedDescription)")
                }
                else {
                    self.NewPass.text = ""
                    self.ReNewPass.text = ""
                    
                    self.PassErrLbl.text = "Success"
                    self.PassErrLbl.backgroundColor = UIColor.green
                    self.PassErrLbl.alpha = 1
                }
            }
        }
    }
    
    
    func showPassError(_ message:String){
     PassErrLbl.text = message
     PassErrLbl.alpha = 1
    }
    
}
