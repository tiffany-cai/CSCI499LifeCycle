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
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        ref?.child("users").child(userID).child("items").queryOrderedByKey().observe(.childAdded, with: { (snapshot) -> Void in
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("swiped")
        let delete = deleteAction(at: indexPath)
        
        // Add delete func to table view when you swipe from left to right
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    // deletes from table view
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") {(action,view,completion) in
            
            // remove from DB
            let itemName = self.items[indexPath.row].name
            print(itemName)
            
            let userID = Auth.auth().currentUser?.uid
            self.ref?.child("users").child(userID!).child("items").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
              // Get user value
                let value = snapshot.value as? NSDictionary
                print(value)
                
                //let username = value?["username"] as? String ?? ""
                //let user = User(username: username)\
                
                // get all keys in a users items list
                /*for key in value!.allKeys{
                    print(key)
                    /*self.ref?.child("users").child(userID!).child("items").child("\(key)").observeSingleEvent(of: .value, with: { (snapshot2) in
                            print(snapshot2)
                    })*/
                }
                    
                print(snapshot.hasChild(itemName))
                    //self.ref?.child("users").child(userID!).child("items").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
                            
                    //})
                    
                
              // ...*/
                
              })
                { (error) in
                print(error.localizedDescription)
            }
            

            
            
            
            //itemRef.child(itemKey).setValue(nil)
            
            // remove from items array
            self.items.remove(at: indexPath.row)
            
            // remove from UI Table View Controller
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
            

            //guard let userID = Auth.auth().currentUser?.uid else { return }
            //self.removeObjectFromFireBase(userKey: userID, name: itemName)

        }
        action.image = UIImage(systemName: "trash")
        action.backgroundColor = .red
        
        return action
    }
    
    // deletes from firebase
    func removeObjectFromFireBase(userKey: String, name: String) {
        let itemRef = Database.database().reference().child("users").child(userKey).child("items")
        
        print(name)
        
        itemRef.queryOrderedByValue().queryEqual(toValue: name).observeSingleEvent(of: .value) { (DataSnapshot) in
            for child in DataSnapshot.children{
                print((child as! DataSnapshot).key)
            }
        }
        
        //itemRef.child(itemKey).setValue(nil)
    }

}
