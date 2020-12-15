//
//  SupportViewController.swift
//  LifeCycle
//
//  Created by John Solano on 10/19/20.
//  Copyright © 2020 John Solano. All rights reserved.
//
import FirebaseFirestore
import UIKit
import Firebase

class SupportViewController: UIViewController {

    @IBOutlet weak var Question: UITextView!
    //@IBOutlet weak var labelSuccess: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set BG
        self.view.backgroundColor = White
        // Do any additional setup after loading the view.
        
        // hide success lbl
        //labelSuccess.alpha = 0;
        
        //add border around textfield
        Question!.layer.borderWidth = 1
        Question!.layer.borderColor = Blackish.cgColor
    }
    
    
    @IBAction func SendBtn(_ sender: Any) {
        //Get USer ID
        guard let userID = Auth.auth().currentUser?.uid else{return}
        
        //add Question to DB
        let db = Firestore.firestore()
        
        db.collection("SupportForm").document(userID).setData([
            "Question" : Question.text!
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
       // showSuccessLabel("Support Form sent successfully!")
    }
    
    /*
    func showSuccessLabel(_ message:String){
     labelSuccess.text = message
     labelSuccess.alpha = 1
    }*/
    

    @IBAction func BackBtn(_ sender: Any) {
        // Return to Setting Page
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let SettingsVC = storyboard.instantiateViewController(identifier: "SettingsViewController")
         (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(SettingsVC)
    }
}

