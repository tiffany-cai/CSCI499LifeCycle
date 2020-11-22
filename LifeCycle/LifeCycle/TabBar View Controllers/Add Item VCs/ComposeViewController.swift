//
//  ComposeViewController.swift
//  LifeCycle
//
//  Created by John Solano on 11/17/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class ComposeViewController: UIViewController {

    var ref : DatabaseReference?
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var house: UIButton!
    @IBOutlet weak var vehicle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
       
    }
    @IBAction func house(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            vehicle.isSelected = false
        }
        else {
            sender.isSelected = true
            vehicle.isSelected = false
        }
    }
    
    @IBAction func vehicle(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            house.isSelected = false
        }
        else {
            sender.isSelected = true
            house.isSelected = false
        }
    }
    
    @IBAction func addPost(_ sender: Any) {
        /* Test to add item objects
        // Get user ID
        let userID = Auth.auth().currentUser!.uid
        // post to firebase
        
        // 1. Make item reference
        let itemRef = ref?.child("users").child(userID).child("items").childByAutoId()
        // 2. create object
            let itemObject = [
                "name" : itemName.text as Any,
                "date": "12-31-2020"
            ] as [String: Any]
        
        // 3. Add object to firebase
        itemRef?.setValue(itemObject, withCompletionBlock: { (err, ref) in
            if err == nil {
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        })
        */
        
        
        /*Old Code for String objects DO NOT DELETE*/
         // Get user ID
         let userID = Auth.auth().currentUser!.uid
         // post to firebase
         ref?.child("users").child(userID).child("items").childByAutoId().setValue(itemName.text)
         
         // dismiss popover
         presentingViewController?.dismiss(animated: true, completion: nil)
         
        // dismiss popover
        //presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        // dismiss popover
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    

}
