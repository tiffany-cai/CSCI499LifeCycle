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
        self.view.backgroundColor = White
        

        
        notification()
        
        // Get ref to db
        ref = Database.database().reference()
        // Get user ID
        let userID = Auth.auth().currentUser!.uid

       //.value looks to added and removed and changed items
    databaseHandle = ref?.child("users").child(userID).child("items").observe(.childAdded, with: { (snapshot ) in
            
        // should be item instead of string
        let post = snapshot.value as? String


        /*
        print("\n POST \n")
        print(post)
        print("\n Snap \n")
        print(snapshot)
        print("\n Snap Value \n")
        print(snapshot.value)
 */
        
        if let actualPost = post {
            self.postData.append(actualPost)
            self.tableView.reloadData()
            }
        })
    }
    
    //MARK: tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        
        cell?.textLabel?.text = postData[indexPath.row]
        
        return cell!
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
