 //
 //  UIColor.swift
 //  LifeCycle
 //
 //  Created by Tiffany Cai on 10/19/20.
 //  Copyright © 2020 John Solano. All rights reserved.
 //
 //to use colors :
 //   view.backgroundColor = SageTan
 // or
 //   view.backgroundColor = UIColor.init(Hex: 0xCBC9AD)

 import UIKit

 //color variables
 var White = UIColor.init(Hex: 0xFFFFFF)
 var Black = UIColor.init(Hex: 0x000000)
 var ArmyGreen = UIColor.init(Hex: 0x514B23)
 var OliveGreen = UIColor.init(Hex: 0x656839)
 var SageTan = UIColor.init(Hex: 0xCBC9AD)
 var AshGray = UIColor.init(Hex: 0xCBD0B9)
 var OpalBlue = UIColor.init(Hex: 0xBDDBD0)
 var SteelTeal = UIColor.init(Hex: 0x7A918D)
 var MorningBlue = UIColor.init(Hex: 0x93B1A7)
 
 var Blackish = UIColor.init(Hex: 0x393e46)


 /*Allows usage of hex colors by properly formatting and creating an extension of UIColor*/
 extension UIColor {
     
     /*
     struct Colors {
         static let ArmyGreen = UIColor.init(Hex: 0x514B23)
         static let OliveGreen = UIColor.init(Hex: 0x656839)
         static let SageTan = UIColor.init(Hex: 0xCBC9AD)
         static let AshGray = UIColor.init(Hex: 0xCBD0B9)
         static let OpalBlue = UIColor.init(Hex: 0xBDDBD0)
     }*/
     
     convenience init(red: Int, green: Int, blue: Int) {
         assert(red >= 0 && red <= 255, "Error: invalid red")
         assert(green >= 0 && green <= 255, "Error: invalid green")
         assert(blue >= 0 && blue <= 255, "Error: invalid blue")
         self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
     }
     
     convenience init(Hex:Int) {
         self.init(red:(Hex >> 16) & 0xff, green:(Hex >> 8) & 0xff, blue:Hex & 0xff)
     }
 }

