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
    // Has to be an array of items
    //var postData = [String]()
    var items = [ItemStruct]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = White
        
        // Get ref to db
        ref = Database.database().reference()
        ref?.child("items").queryOrderedByKey().observe(.childAdded, with: { (snapshot) -> Void in
        
            let dict = snapshot.value as! [String: Any]
            let name = dict["name"] as! String
            let date = dict["date"] as! String
            
            self.items.append(ItemStruct(name:name, date:date))
            self.tableView.reloadData()
        })
    }
    
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
          return 70
    }

}
