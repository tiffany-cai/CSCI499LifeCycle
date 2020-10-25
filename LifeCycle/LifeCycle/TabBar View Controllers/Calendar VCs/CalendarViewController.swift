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

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource,FSCalendarDelegateAppearance  {
    /*
     as a user I want to ...
     - delete items
     - see details (Start Date/End Date)
     - edit item (Start Date)
     - See items and its details
     
     
    User struct
     -- pull start dates and item IDs from here
     
     */
    
    var calendar:FSCalendar!
    var formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar = FSCalendar(frame: CGRect(x: 0.0, y: 40.0, width: self.view.frame.size.width,height: 300.0))
        calendar.scrollDirection = .horizontal
        calendar.scope = .month
        self.view.addSubview(calendar)
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 16.0)
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 14.0)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 15.0)
        
        calendar.appearance.todayColor = .systemGreen
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.titleDefaultColor = .systemTeal
        
        calendar.appearance.headerTitleColor = .systemPink
        calendar.appearance.weekdayTextColor = .systemRed
        //calendar.calendarHeaderView.collectionViewLayout =
        //calendar.appearance.headerTitleTextSize = 18.0

        
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.allowsMultipleSelection = true
        
    }
    

    // datasource
    // this marks the current date
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date().addingTimeInterval((24*60*60)*60)
    }
    // this places a dot on date with an event
    func calendar(_ calendar:FSCalendar, numberOfEventsFor date: Date) -> Int {
           formatter.dateFormat = "dd-MM-yyyy"
             guard let eventDate = formatter.date(from: "25-10-2020") else { return  0}
        if date.compare(eventDate) == .orderedSame {
            return 5
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
        guard let excludedDate = formatter.date(from: "26-10-2020") else { return nil}
        if date.compare(excludedDate) == .orderedSame {
            return .purple
            }
        return nil
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





