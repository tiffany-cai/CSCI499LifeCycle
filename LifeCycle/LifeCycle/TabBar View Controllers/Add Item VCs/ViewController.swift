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
        
        //notification()
        
        
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
        
        /*
        let label1 = cell?.viewWithTag(1) as! UILabel
        label1.text = items[indexPath.row].name
        
        let label2 = cell?.viewWithTag(2) as! UILabel
        label2.text = items[indexPath.row].date
        */
        return cell
    }
    
    func tableView(_ tableView: UITableView,
               heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 70
    }
    
    //MARK: notifications
    
    //notification pops up asking for permission
    func notification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {success, error in
            if success {
                print("User granted notifs!")
            }
            else if error != nil {
                print("error, user did not grant notif")
            }
        })
    }
    
    func scheduleNotification(itemName: String, alarmTime: Date) {
        
        let content = UNMutableNotificationContent()
        
        //this is what you want each part of the notification to say
        content.title = itemName
        content.body = "This item may need maintainence soon."
        content.sound = .default

        //this is what takes the date and schedules the notif
        let schedule = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: alarmTime), repeats: false)
        
        //to help accesss specific notifications upon deletion, throws in time notification is to be done to differenciate between one another
        let request = UNNotificationRequest(identifier: "notif \(String(describing: itemName))", content: content, trigger: schedule)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            if error != nil {
                print("error")
            }
        })
    }

}
