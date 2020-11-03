//
//  ItemTableViewController.swift
//
//
//  Created by Tiffany Cai on 10/20/20.
//

import UIKit

//delete later, this is for testing purposes. connect with database later
class Items {
    var ItemName: String?
    var ItemInfo: String?
    
    init(IName:String, IInfo:String) {
        self.ItemName = IName
        self.ItemInfo = IInfo
    }
}
//end of delete later

class ItemTableViewController: UITableViewController {
    
    @IBOutlet weak var ItemList: UITableView!
        
    var ItemListArray = [Items]()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //for test, delete after connecting with database
        let ACfilter = Items(IName: "AC filters", IInfo: "Reccomended maintenance in 2 weeks")
        ItemListArray.append(ACfilter)
        
        let Mattress = Items(IName: "Bedroom Mattress", IInfo: "Reccomended maintenance in 7 years")
        ItemListArray.append(Mattress)
        //end delete
        
        ItemList.delegate = self
        ItemList.dataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemListArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ItemListCell
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "ListCell") as! ItemListCell
        }
        
        cell.labelItemName.text = ItemListArray[indexPath.row].ItemName
        
        cell.labelItemDetail?.text = ItemListArray[indexPath.row].ItemInfo
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowDetail", sender: self)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.Item = ItemListArray[(ItemList.indexPathForSelectedRow?.row)!]
        }
    }
    

}
