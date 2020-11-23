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
    
    private func btnConfig() {
        setTitleColor(White, for: .normal)
        backgroundColor = SteelTeal
        titleLabel?.font = UIFont(name: "Chalkboard", size: 22)
        
    }
}

class ConfirmBtn : UIButton {
    override init(frame: CGRect){
        super.init(frame: frame)
        btnConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        btnConfig()
    }
    
    private func btnConfig(){
        setTitleColor(White, for: .normal)
        backgroundColor = SteelTeal
        titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 22)
        layer.cornerRadius = self.frame.height / 2
    }
}
