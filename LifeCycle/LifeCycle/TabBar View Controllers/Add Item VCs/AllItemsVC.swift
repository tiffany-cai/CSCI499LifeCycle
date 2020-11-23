//
//  AddItemViewController.swift
//  LifeCycle
//
//  Created by John Solano on 10/10/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit

class AllItemsVC: UIViewController {

    /*
     Item struct for DB
     
     Item name: string
     Image : UIImage   // User Image taken from phone, keep default for now
     Maintenence Time Period : Int (days)
     Vechicle : bool
      -- Manuals: link ?
     
     
     User struct
     
     Items {
        items's foreign key {
            UID: string
            Start Date: date
            End Date: date
            isFinished :bool
        }
     }
     
     isFinished.count()
     
     
     
     
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.view.backgroundColor = UIColor.AppColors.AshGrey
    }
    
}
