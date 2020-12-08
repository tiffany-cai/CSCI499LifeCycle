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
    let lifecycle : String
}

class itemCell: UITableViewCell {
    @IBOutlet var name : UILabel?
    @IBOutlet var date : UILabel?
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    var ref : DatabaseReference?
    var databaseHandle : DatabaseHandle?
    //var items = [ItemStruct]()
    
    var seeds = [ItemStruct]()
    var plants = [ItemStruct]()
    
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
            let life = dict["lifecycle"] as! String
            
            //self.items.append(ItemStruct(name:name, date:date, lifecycle: life))
            if life == "seed"{
                self.seeds.append(ItemStruct(name:name, date:date, lifecycle: life))
            }else{
                self.plants.append(ItemStruct(name:name, date:date, lifecycle: life))
            }
            self.tableView.reloadData()
        })
        
    } // End of view did load
    
    //MARK: tableview data source
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let titles = ["Seeds", "Plants"]
            if section < titles.count {
                return titles[section]
            }

            return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
            case 0:
                return seeds.count
            case 1:
                return plants.count
            default:
                return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        
        if indexPath.section == 0 {
            let SeedCell = tableView.dequeueReusableCell(withIdentifier: "SeedCell") as! itemCell
            let item = seeds[indexPath.row]
            SeedCell.name?.text = item.name
            SeedCell.date?.text = item.date
            return SeedCell
        }
        
            let PlantCell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! itemCell
            let plant = plants[indexPath.row]
            PlantCell.name?.text = plant.name
            PlantCell.date?.text = plant.date
            return PlantCell
        
    }
        /*
        let SeedCell = tableView.dequeueReusableCell(withIdentifier: "SeedCell") as! itemCell
        let PlantCell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! itemCell
        
        
        
        // Fetch the data for the row.
        let seed = seeds[indexPath.row]
        let plant = plants[indexPath.row]
        
        // Configure the cell’s contents with data from the fetched object.
        SeedCell.name?.text = seed.name
        SeedCell.date?.text = seed.date
        
        PlantCell.name?.text = plant.name
        PlantCell.date?.text = plant.date
        
        if indexPath.row < seeds.count{
            return SeedCell
        }
        
        return PlantCell
 */
    
    
    func tableView(_ tableView: UITableView,
               heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 85
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("swiped")
        print(seeds)
        print(plants)
        print(indexPath)
        let delete = deleteAction(at: indexPath)
        
        // Add delete func to table view when you swipe from left to right
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    // deletes from table view
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") {(action,view,completion) in
            
            if indexPath.section == 0{
                let seedName = self.seeds[indexPath.row].name
                print(seedName)
                
                let userID = Auth.auth().currentUser?.uid
                let itemRef = self.ref?.child("users").child(userID!).child("items")
                itemRef?.queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
                  // Get user value
                    //let value = snapshot.value as? NSDictionary
                    let value = snapshot.value as? [String: Any]
                    var keyItemPair = [String:String]()
                    for v in value!{
                        //print(v.key)
                        let dict = v.value as! [String: Any]
                        let name = dict["name"] as! String
                        //print(name)
                        keyItemPair["\(v.key)"] = name
                    }
                    for x in keyItemPair{
                        if (x.value == seedName){
                            //print(x.key)
                            itemRef?.child(x.key).setValue(nil)
                        }
                    }
                  })
                    { (error) in
                    print(error.localizedDescription)
                }
                // remove from seeds array
                self.seeds.remove(at: indexPath.row)
                // remove from UI Table View Controller
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }else{
                let plantName = self.plants[indexPath.row].name
                let userID = Auth.auth().currentUser?.uid
                let itemRef = self.ref?.child("users").child(userID!).child("items")
                itemRef?.queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? [String: Any]
                    var keyItemPair = [String:String]()
                    for v in value!{
                        let dict = v.value as! [String: Any]
                        let name = dict["name"] as! String
                        keyItemPair["\(v.key)"] = name
                    }
                    for x in keyItemPair{
                        if (x.value == plantName){
                            itemRef?.child(x.key).setValue(nil)
                        }
                    }
                  })
                    { (error) in
                    print(error.localizedDescription)
                }
                self.plants.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }

            completion(true)
            
        }
        action.image = UIImage(systemName: "trash")
        action.backgroundColor = .red
        
        return action
    }



}
