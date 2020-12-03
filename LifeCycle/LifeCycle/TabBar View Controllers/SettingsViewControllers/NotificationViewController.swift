//
//  NotificationViewController.swift
//  LifeCycle
//
//  Created by John Solano on 10/19/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class NotificationViewController: UIViewController {
    @IBOutlet weak var quarter: UIButton!
    @IBOutlet weak var half: UIButton!
    @IBOutlet weak var full: UIButton!
    @IBOutlet weak var none: UIButton!
    @IBOutlet weak var SuccessLbl: UILabel!
    
    /*
     
     End Dates from logged in users item table
     
     Controling phones sound/vibrations
     
     changing snooze time
     
     */
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set BG
        //self.view.backgroundColor = UIColor.AppColors.AshGrey
        // hide success lbl
        SuccessLbl.alpha = 0;
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
        // Get ref to db
        ref = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        // change Snooze variable in db
        if (quarter.isSelected == true){
            ref?.child("users").child(userID).updateChildValues(["Snooze" : 15])
            showSuccessLbl("Snooze time set to 15 mins")
        }
        if (half.isSelected == true){
            ref?.child("users").child(userID).updateChildValues(["Snooze" : 30])
            showSuccessLbl("Snooze time set to 30 mins")
        }
        if (full.isSelected == true){
            ref?.child("users").child(userID).updateChildValues(["Snooze" : 60])
            showSuccessLbl("Snooze time set to 1 hour")
        }
        if (none.isSelected == true){
            ref?.child("users").child(userID).updateChildValues(["Snooze" : 0])
            showSuccessLbl("Snooze time turned off")
        }
        
        
        // return to tab bar
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let SettingsVC = storyboard.instantiateViewController(identifier: "SettingsViewController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(SettingsVC)
 */
    }
    
    func showSuccessLbl(_ message:String){
     SuccessLbl.text = message
     SuccessLbl.alpha = 1
    }
}
