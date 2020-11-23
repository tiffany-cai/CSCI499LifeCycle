//
//  NavBarConfig.swift
//  LifeCycle
//
//  Created by John Solano on 10/24/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit

class NavBarConfig: UINavigationBar {

    override func awakeFromNib() {
            super.awakeFromNib()
            setTitleAttribute()
            setBGColor()
            setBackBtn()
    }
    
    func setTitleAttribute(){
        //let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black,NSAttributedString.Key.font: UIFont(name: "ChalkboardSE-Light", size: 18)!]
        
        //set only title color of navigation bar by below code
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.titleTextAttributes = textAttributes
    }
    
    func setBGColor(){
        self.barTintColor = SteelTeal
        self.backgroundColor = White

    }
    
    func setBackBtn(){
        self.tintColor = SteelTeal
    }
}
