//
//  DetailViewController.swift
//  LifeCycle
//
//  Created by Tiffany Cai on 10/26/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var labelItemName: UILabel!
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var labelDetails: UILabel!
    
    var Item: Items?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        labelItemName.text = "\((Item?.ItemName)!)"
        labelDetails.text = "\((Item?.ItemInfo)!)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
