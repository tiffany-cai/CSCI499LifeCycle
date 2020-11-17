//
//  ViewController.swift
//  LifeCycle
//
//  Created by John Solano on 11/17/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref : DatabaseReference?
    var databaseHandle : DatabaseHandle?
    // Has to be an array of items
    var postData = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Get items
        ref = Database.database().reference()
        // Get user ID
        let userID = Auth.auth().currentUser!.uid

       //.value looks to added and removed and changed items
    databaseHandle = ref?.child("users").child(userID).child("items").observe(.childAdded, with: { (snapshot ) in
            
        // should be item instead of string
        let post = snapshot.value as? String
        
        if let actualPost = post {
            self.postData.append(actualPost)
            self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        
        cell?.textLabel?.text = postData[indexPath.row]
        
        return cell!
    }

}
