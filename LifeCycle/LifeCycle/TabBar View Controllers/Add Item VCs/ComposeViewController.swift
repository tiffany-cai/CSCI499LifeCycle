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
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
       
    }
    
    @IBAction func addPost(_ sender: Any) {
        // Get user ID
        let userID = Auth.auth().currentUser!.uid
        // post to firebase
        ref?.child("users").child(userID).child("items").childByAutoId().setValue(itemName.text)
        
        // dismiss popover
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        // dismiss popover
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    

}
