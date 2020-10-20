//
//  BackToSettingsButton.swift
//  LifeCycle
//
//  Created by John Solano on 10/19/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit

class SettingsBackButton: UIButton {

    override init(frame: CGRect){
        super.init(frame: frame)
        btnConfig()
    }
    
    // for storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        btnConfig()
    }
    
    func btnConfig() {
        setTitleColor(UIColor.AppColors.Sage, for: .normal)
        backgroundColor = UIColor.AppColors.DarkOliveGreen
        titleLabel?.font = UIFont(name: "Chalkboard", size: 22)
        
        
    }
}
