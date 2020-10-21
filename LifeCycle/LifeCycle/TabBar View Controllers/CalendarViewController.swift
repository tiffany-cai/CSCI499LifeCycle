//
//  CalendarViewController.swift
//  LifeCycle
//
//  Created by John Solano on 10/10/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    /*
     as a user I want to ...
     - delete items
     - see details (Start Date/End Date)
     - edit item (Start Date)
     - See items and its details
     
     
    User struct
     -- pull start dates and item IDs from here
     
     */
    
    fileprivate weak var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.register(FSCalendarCell.self,forCellReuseIdentifier: "CELL")
        calendar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendar)
        
        
        
        calendar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        calendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calendar.heightAnchor.constraint(equalToConstant:  375).isActive = true
        calendar.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        
        
        self.calendar = calendar


    }

}
extension UIViewController: FSCalendarDataSource,FSCalendarDelegate{
//    public func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return"sophia.io"
//    }
//    public func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        return"testing"
//    }
    
//    public func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(named: "AppIcon")
//    }
    public func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
         return cell
    }
}
