//
//  CustomLabels.swift
//  LifeCycle
//
//  Created by John Solano on 10/24/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit

class H1Label: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.LabelConfig()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.LabelConfig()
    }
    
    func LabelConfig(){
        textColor = UIColor.black
        font = UIFont(name: "HelveticaNeue-Light", size: 25)
    }

}

class H2Label: UILabel {


}

class RegLabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.LabelConfig()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.LabelConfig()
    }
    
    func LabelConfig(){
        textColor = UIColor.black
        font = UIFont(name: "HelveticaNeue-Light", size: 20)
    }
}
