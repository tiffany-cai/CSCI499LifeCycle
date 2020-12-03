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


struct ItemStruct {
    let name : String
    let date : String
}

class itemCell: UITableViewCell {
    @IBOutlet var name : UILabel?
    @IBOutlet var date : UILabel?
    
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref : DatabaseReference?
    var databaseHandle : DatabaseHandle?
    var items = [ItemStruct]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NavBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get ref to db
        ref = Database.database().reference()
        
        tableView.delegate = self
        tableView.dataSource = self
        NavBar.title = "Welcome"
        //self.view.backgroundColor = White
        

        notification()
        
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        ref?.child("users").child(userID).child("items").queryOrderedByKey().observe(.childAdded, with: { (snapshot) -> Void in

        // Get ref to db
        ref = Database.database().reference()
        ref?.child("items").queryOrderedByKey().observe(.childAdded, with: { (snapshot) -> Void in
        
            let dict = snapshot.value as! [String: Any]
            let name = dict["name"] as! String
            let date = dict["date"] as! String
            
            self.items.append(ItemStruct(name:name, date:date))
            self.tableView.reloadData()
        })
        
    } // End of view did load
    
    //MARK: tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! itemCell
        
        // Fetch the data for the row.
        let theItems = items[indexPath.row]
        
        // Configure the cell’s contents with data from the fetched object.
        cell.name?.text = theItems.name
        cell.date?.text = theItems.date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
               heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 85
    }

}
