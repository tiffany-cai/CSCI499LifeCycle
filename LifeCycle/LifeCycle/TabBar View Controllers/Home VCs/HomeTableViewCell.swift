//
//  HomeListTableViewCell.swift
//  LifeCycle
//
//  Created by Tiffany Cai on 10/26/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelHomeItemName: UILabel!
    @IBOutlet weak var labelHomeItemInfo: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
