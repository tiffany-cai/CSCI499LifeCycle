//
//  CalendarViewController.swift
//  LifeCycle
//
//  Created by John Solano on 10/10/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

//https://www.youtube.com/watch?v=FipNDF7g9tE&t=298s

import UIKit
import FSCalendar
import FirebaseAuth
import FirebaseDatabase


class calItems {
    var calItemName: String?
    var calItemInfo: String?
    
    init(cal_list:String, cal_info:String) {
        self.calItemName = cal_list
        self.calItemInfo = cal_info
    }
}

class CalendarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, FSCalendarDelegate, FSCalendarDataSource,FSCalendarDelegateAppearance  {
    
    @IBOutlet weak var CalList: UITableView!

    var calItemArray = [calItems]()
    //var calendar:FSCalendar!
    @IBOutlet var calendar: FSCalendar!
    
    //var formatter = DateFormatter()
    //formats the dates this way, so xcode knows how to read the dates, used in the dot function when it reads the dates in the array
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    
    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveData()
        
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        calendar = FSCalendar(frame: CGRect(x: 0.0, y: 125.0,
                                            width: self.view.frame.size.width,
                                            height: self.view.frame.size.width))
        calendar.scrollDirection = .vertical
        calendar.scope = .month
        self.view.addSubview(calendar)
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 16.0)
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18.0)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 15.0)
        
        calendar.appearance.todayColor = MorningBlue
        
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.titleDefaultColor = Black
        
        calendar.appearance.headerTitleColor = SteelTeal
        //calendar.appearance.headerTitleColor = .systemPink
        calendar.appearance.weekdayTextColor = SteelTeal
    
        //calendar.calendarHeaderView.collectionViewLayout =
        //calendar.appearance.headerTitleTextSize = 18.0

        
        calendar.delegate = self
        calendar.dataSource = self
    
        calendar.allowsMultipleSelection = false
        
        
        CalList.delegate = self
        CalList.dataSource = self

        
        
    }
    
    
    func retrieveData() {
        //This is how to retrieve all the item names, keys and dates
        //you can append all data to a dictionary, or create an array
        guard let userID = Auth.auth().currentUser?.uid else { return }
        ref = Database.database().reference()
        ref?.child("users").child(userID).child("items").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? [String: Any]
            for v in value! {
                print(v.key)
                let dict = v.value as! [String: Any]
                let name = dict["name"] as! String
                print(name)
                let date = dict["date"] as! String
                print(date)
                print("")
            }
        })
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    var cell = tableView.dequeueReusableCell(withIdentifier: "CalCell", for: indexPath) as! CalendarTableViewCell
    
        if cell == nil {
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CalCell") as! CalendarTableViewCell
    }
    
       /* cell.labelcallItemName.text = calItemArray[indexPath.row].calItemName
    
        cell.labelcallItemDetail.text = calItemArray[indexPath.row].calItemInfo*/
    
    return cell
    
    }

    // datasource
    // this marks the current date
   /* func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }*/
    
   /* func maximumDate(for calendar: FSCalendar) -> Date {
        return Date().addingTimeInterval((24*60*60)*3666);
    }*/
    // this places a dot on date with an event
   /* func calendar(_ calendar:FSCalendar, numberOfEventsFor date: Date) -> Int {
           formatter.dateFormat = "dd-MM-yyyy"
             guard let eventDate = formatter.date(from: "28-11-2020") else { return  0}
        if date.compare(eventDate) == .orderedSame {
            return 1
        }
        return 0
    }*/
    
    //array with one event
    var datesWithEvent = ["12/01/2020", "12/03/2020", "12/17/2020", "12/20/2020"]
    //array with multiple events
    var datesWithMultipleEvents = ["12/25/2020", "12/30/2020"]

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let dateString = self.dateFormatter.string(from: date)
        if self.datesWithEvent.contains(dateString) {
            return 1
        }
        if self.datesWithMultipleEvents.contains(dateString) {
            return 3 //make return number of events on day
        }
        return 0
    }
    
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let day: Int! = self.gregorian.component(.day, from: date)
        return [13,24].contains(day) ? UIImage(named: "icon_cat") : nil
    }
    

    // this marks the delegate select
   /* func calendar( _ calendar: FSCalendar,didSelect date:Date,at atMonthPosition:FSCalendarMonthPosition){
            formatter.dateFormat = "dd-MM-yyyy"
            //print("Selected Date ==\(formatter.string(from:date))")
            let formattedDate = formatter.string(from: date)
            let myAlert = UIAlertController (title: "Tasks Due", message: formattedDate, preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel)
            let update = UIAlertAction(title: "Update", style: .destructive)
            myAlert.addAction(dismiss)
            myAlert.addAction(update)

            present(myAlert, animated: true )
        }*/
    // this marks the delegate deselect
   /* func calendar( _ calendar: FSCalendar,didDeselect date:Date,at atMonthPosition:FSCalendarMonthPosition){
            formatter.dateFormat = "dd-MM-yyyy"
            print("De-Selected Date ==\(formatter.string(from:date))")
    
        }*/
// exclede selected date
  /*  func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at atMonthPosition: FSCalendarMonthPosition) -> Bool {
        formatter.dateFormat = "dd-MM-yyyy"
        guard let excludedDate = formatter.date(from: "24-10-2020") else { return  true}
        if date.compare(excludedDate) == .orderedSame {
            return false
        }
        
        return  true
    }*/
        
   /* func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        formatter.dateFormat = "dd-MM-yyyy"
        guard let excludedDate = formatter.date(from: "06-11-2020") else { return nil}
        if date.compare(excludedDate) == .orderedSame {
            return .purple
            }
        return nil
    }*/
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calItemArray.count
    }
        
      
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //performSegue(withIdentifier: "Cal", sender: self)
    }
        
        
        
//        calendar.register(FSCalendarCell.self,forCellReuseIdentifier: "CELL")
//        calendar.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(calendar)
//
//
//
//        calendar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        calendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        calendar.heightAnchor.constraint(equalToConstant:  375).isActive = true
//        calendar.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        
        
       // self.calendar = calendar

    
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
}


    


//extension UIViewController: FSCalendarDataSource,FSCalendarDelegate{
//    public func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return"sophia.io"
//    }
//    public func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        return"testing"
//    }
    
//    public func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(named: "AppIcon")
//    }
//    public func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//        let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
//         return cell
//    }
//}





