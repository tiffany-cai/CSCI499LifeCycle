//
//  CalendarTableViewCell.swift
//  LifeCycle
//
//  Created by Sophia Bonsu on 11/5/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import Foundation
import UIKit

class CalendarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelcallItemName: UILabel!
    @IBOutlet weak var labelcallItemDetail: UILabel!

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
