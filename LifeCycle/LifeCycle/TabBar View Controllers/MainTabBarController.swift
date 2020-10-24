//
//  MainAppTabBarController.swift
//  LifeCycle
//
//  Created by John Solano on 10/10/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Change BG Color
        
        
        //ref to db
        let db = Firestore.firestore()
        db.collection("users").document("\(Auth.auth().currentUser!.uid)").getDocument { (document, err) in
            //Check for error aka uid doesnt exist
            if err == nil{
                //check it exists in the collection
                if document != nil && document!.exists {
                    let documentData = document!.data()
                    
                    print(documentData!)
                    
                }
            }
            
        }
    } // end of view did load
    

    

}
