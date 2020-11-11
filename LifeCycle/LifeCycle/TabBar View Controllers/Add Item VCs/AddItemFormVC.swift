//
//  AddItemFormVC.swift
//  LifeCycle
//
//  Created by John Solano on 10/25/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit

class AddItemFormVC: UIViewController {

    @IBOutlet weak var buttonCancel: UIBarButtonItem!
    @IBOutlet weak var labelItemName: UILabel!
    @IBOutlet weak var textfieldItemName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.AppColors.AshGrey
    }
    
    @IBAction func confirmBtc(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let AllVC = storyboard.instantiateViewController(identifier: "AllItemsVC")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(AllVC)
    }
    
    @IBAction func buttonCancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
