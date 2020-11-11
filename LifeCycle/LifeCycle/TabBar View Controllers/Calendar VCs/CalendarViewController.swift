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



class calItems {
    var calItemName: String?
    var calItemInfo: String?
    
    init(cal_list:String, cal_info:String) {
        self.calItemName = cal_list
        self.calItemInfo = cal_info
    }
}

class CalendarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, FSCalendarDelegate, FSCalendarDataSource,FSCalendarDelegateAppearance  {
    
    
//
    /*
     as a user I want to ...
     - delete items
     - see details (Start Date/End Date)
     - edit item (Start Date)
     - See items and its details
     
     
    User struct
     -- pull start dates and item IDs from here
     
     */
    
    @IBOutlet weak var CalList: UITableView!

    var calItemArray = [calItems]()
    var calendar:FSCalendar!
    var formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        calendar = FSCalendar(frame: CGRect(x: 0.0, y: 100.0,
                                            width: self.view.frame.size.width,
                                            height: self.view.frame.size.width))
        calendar.scrollDirection = .vertical
        calendar.scope = .month
        self.view.addSubview(calendar)
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 16.0)
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18.0)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 15.0)
        
        calendar.appearance.todayColor = UIColor.AppColors.ArmyGreen
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.titleDefaultColor = UIColor.AppColors.Opal
        
        calendar.appearance.headerTitleColor = UIColor.AppColors.DarkOliveGreen
        //calendar.appearance.headerTitleColor = .systemPink
        calendar.appearance.weekdayTextColor = UIColor.AppColors.AshGrey
    
        //calendar.calendarHeaderView.collectionViewLayout =
        //calendar.appearance.headerTitleTextSize = 18.0

        
        calendar.delegate = self
        calendar.dataSource = self
    
        calendar.allowsMultipleSelection = false
        
        
        let NemoHouse = calItems(cal_list: "Nemo's House", cal_info: "42 Wallaby Way, Sydney")
        calItemArray.append(NemoHouse)
        
        let SimpsonHouse = calItems(cal_list: "Simpson's House", cal_info: "742 Evergreen Terrace")
        calItemArray.append(SimpsonHouse)

        let Apartment = calItems(cal_list: "My Apartment", cal_info: "stuytown")
        calItemArray.append(Apartment)

        let Car = calItems(cal_list: "Pearl", cal_info: "Lexus LFA")
        calItemArray.append(Car)
        //end of delete
        
        
        CalList.delegate = self
        CalList.dataSource = self

        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    var cell = tableView.dequeueReusableCell(withIdentifier: "CalCell", for: indexPath) as! CalendarTableViewCell
    
        if cell == nil {
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CalCell") as! CalendarTableViewCell
    }
    
        cell.labelcallItemName.text = calItemArray[indexPath.row].calItemName
    
        cell.labelcallItemDetail.text = calItemArray[indexPath.row].calItemInfo
    
    return cell
    
    }

    // datasource
    // this marks the current date
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date().addingTimeInterval((24*60*60)*3666);
    }
    // this places a dot on date with an event
    func calendar(_ calendar:FSCalendar, numberOfEventsFor date: Date) -> Int {
           formatter.dateFormat = "dd-MM-yyyy"
             guard let eventDate = formatter.date(from: "25-11-2020") else { return  0}
        if date.compare(eventDate) == .orderedSame {
            return 2
        }
        return 0
    }

    

    // this marks the delegate select
    func calendar( _ calendar: FSCalendar,didSelect date:Date,at atMonthPosition:FSCalendarMonthPosition){
            formatter.dateFormat = "dd-MM-yyyy"
            print("Selected Date ==\(formatter.string(from:date))")
    
        }
    // this marks the delegate deselect
    func calendar( _ calendar: FSCalendar,didDeselect date:Date,at atMonthPosition:FSCalendarMonthPosition){
            formatter.dateFormat = "dd-MM-yyyy"
            print("De-Selected Date ==\(formatter.string(from:date))")
    
        }
// exclede selected date
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at atMonthPosition: FSCalendarMonthPosition) -> Bool {
        formatter.dateFormat = "dd-MM-yyyy"
        guard let excludedDate = formatter.date(from: "24-10-2020") else { return  true}
        if date.compare(excludedDate) == .orderedSame {
            return false
        }
        
        return  true
    }
        
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        formatter.dateFormat = "dd-MM-yyyy"
        guard let excludedDate = formatter.date(from: "06-11-2020") else { return nil}
        if date.compare(excludedDate) == .orderedSame {
            return .purple
            }
        return nil
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calItemArray.count
    }
        
        
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "Cal", sender: self)
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





