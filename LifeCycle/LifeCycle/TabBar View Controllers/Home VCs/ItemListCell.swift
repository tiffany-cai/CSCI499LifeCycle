//
//  ItemListCell.swift
//  LifeCycle
//
//  Created by Tiffany Cai on 10/26/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit

class ItemListCell: UITableViewCell {
    
    @IBOutlet weak var labelItemName: UILabel!
    @IBOutlet weak var labelItemDetail: UILabel!
    @IBOutlet weak var ImageItem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
