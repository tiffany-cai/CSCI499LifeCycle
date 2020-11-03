//
//  HomeTableViewController.swift
//  LifeCycle
//
//  Created by Tiffany Cai on 10/12/20.
//  Copyright © 2020 John Solano. All rights reserved.
//

import UIKit

//delete later, this is for testing purposes. connect with database later
class HomeItems {
    var HomeItemName: String?
    var HomeItemInfo: String?
    
    init(HIName:String, HIInfo:String) {
        self.HomeItemName = HIName
        self.HomeItemInfo = HIInfo
    }
}
//end of delete later

class HomeTableViewController: UITableViewController {
    
    @IBOutlet weak var HomeList: UITableView!
    
    var HomeItemArray = [HomeItems]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeCell")
        
        //for test, delete after connecting with database
        let NemoHouse = HomeItems(HIName: "Nemo's House", HIInfo: "42 Wallaby Way, Sydney")
        HomeItemArray.append(NemoHouse)
        
        let SimpsonHouse = HomeItems(HIName: "Simpson's House", HIInfo: "742 Evergreen Terrace")
        HomeItemArray.append(SimpsonHouse)
        
        let Apartment = HomeItems(HIName: "My Apartment", HIInfo: "stuytown")
        HomeItemArray.append(Apartment)
        
        let Car = HomeItems(HIName: "Pearl", HIInfo: "Lexus LFA")
        HomeItemArray.append(Car)
        //end of delete
        
        HomeList.delegate = self
        HomeList.dataSource = self
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeItemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "HomeCell") as! HomeTableViewCell
        }
        
        cell.labelHomeItemName.text = HomeItemArray[indexPath.row].HomeItemName
        
        cell.labelHomeItemInfo?.text = HomeItemArray[indexPath.row].HomeItemInfo
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowItems", sender: self)
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
/*
    override func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = storyboard?.instantiateViewController(withIdentifier: "ItemTableViewController") as? ItemTableViewController
        self.navigationController?.pushViewController(view!, animated: true)
    }*/
    
}
