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
import UserNotifications


class ComposeViewController: UIViewController {

    var ref : DatabaseReference?
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var house: UIButton!
    @IBOutlet weak var vehicle: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notification()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        inputTextField.inputView = datePicker

        ref = Database.database().reference()
       
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        inputTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @IBAction func house(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            vehicle.isSelected = false
        }
        else {
            sender.isSelected = true
            vehicle.isSelected = false
        }
    }
    
    @IBAction func vehicle(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            house.isSelected = false
        }
        else {
            sender.isSelected = true
            house.isSelected = false
        }
    }
    
    @IBAction func addPost(_ sender: Any) {
        let name = itemName.text! as NSString
        let date = inputTextField.text! as NSString
        
        print(name) // test
        print(date) // 11/30/2020 11:59 PM
        
        let item : [String : AnyObject] = [
            "name" : name,
            "date" : date
        ]
        
        //ref?.child("items").childByAutoId().setValue(item)
       guard let userID = Auth.auth().currentUser?.uid else { return }
        ref?.child("users").child(userID).child("items").childByAutoId().setValue(item)
        
        /* Test to add item objects
        // Get user ID
        let userID = Auth.auth().currentUser!.uid
        // post to firebase
        
        // 1. Make item reference
        let itemRef = ref?.child("users").child(userID).child("items").childByAutoId()
        // 2. create object
            let itemObject = [
                "name" : itemName.text as Any,
                "date": "12-31-2020"
            ] as [String: Any]
        
        // 3. Add object to firebase
        itemRef?.setValue(itemObject, withCompletionBlock: { (err, ref) in
            if err == nil {
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        })
        */
        
        
        /*Old Code for String objects DO NOT DELETE*/
        /*
         // Get user ID
         let userID = Auth.auth().currentUser!.uid
         // post to firebase
    
        //let combine = [ "item": itemName.text, "cleaning" : inputTextField.text]
        ref?.child("users").child(userID).child("items").childByAutoId().setValue(itemName.text)
        ref?.child("users").child(userID).child("items").childByAutoId().setValue(inputTextField.text)
            
         // dismiss popover
         presentingViewController?.dismiss(animated: true, completion: nil)
         */
        // dismiss popover
        
        let Ndate = datePicker!.date
        //let itemN = Text(itemName)
        scheduleNotification(itemName: name as String, alarmTime: Ndate)
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        // dismiss popover
        presentingViewController?.dismiss(animated: true, completion: nil)
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
    
    //scheduling the notif
    func scheduleNotification(itemName: String, alarmTime: Date) {
        
        ref = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        ref?.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
        let snoozeTime = value?["Snooze"] as! Double
            
            print("Snooze Time is set to: ")
            print(snoozeTime)
          
            // first reminder
                let content = UNMutableNotificationContent()
                //this is what you want each part of the notification to say
                content.title = itemName
                content.body = "This item may need maintainence soon."
                content.sound = .default
                let schedule = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.month, .day, .year, .hour, .minute], from: alarmTime), repeats: false)
                let request = UNNotificationRequest(identifier: "notif \(String(describing: itemName))", content: content, trigger: schedule)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
                    if error != nil {
                        print("error")
                    }
                })
            
            
            if (snoozeTime == 0){
             // do not send 2nd reminder
                // do nothing
                print("snoozetime is set to 0, second notification not created")
            }else {
                print("snoozetime is not set to 0")
             // send 2nd reminder
                let content2 = UNMutableNotificationContent()
                
                //this is what you want each part of the notification to say
                content2.title = itemName
                content2.body = "Reminder"
                content2.sound = .default
                let schedule2 = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.month, .day, .year, .hour, .minute], from: alarmTime.addingTimeInterval(snoozeTime)), repeats: false)
                
                // DO NOT DELETE
                //snoozeTime * 60.0
                //print("Second notification created in Seconds: ")
                //print(snoozeTime * 60.0)
                
                let request2 = UNNotificationRequest(identifier: "reminder \(String(describing: itemName))", content: content2, trigger: schedule2)
                UNUserNotificationCenter.current().add(request2, withCompletionHandler: {error in
                    if error != nil {
                        print("error")
                    }
                })
                
            } // end else
            
            }) { (error) in
                print(error.localizedDescription)
            }
            
    }

}
