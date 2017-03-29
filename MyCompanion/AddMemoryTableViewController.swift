//
//  AddMemoryTableViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/17/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit

class AddMemoryTableViewController: UITableViewController {

    var types = ["11LP", "11RP", "11TP", "11DP", "11LV", "11RV", "11TV", "11DV", "1T", "1P", "1V"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0 || section == 1) {
            return 4
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {

        switch(section){
            
            case 0: return "1 text, 1 pic"
            case 1: return "1 text, 1 vid"
            case 2: return "1 text"
            case 3: return "1 pic"
            case 4: return "1 vid"
            default: return "mistake"
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "templateType", for: indexPath)

        cell.textLabel?.text = types[convertIndexPathToRow(indexPath: indexPath)]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellClicked:Int = convertIndexPathToRow(indexPath: indexPath)
        
        if(indexPath.section == 0 || indexPath.section == 1) {
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "AddLabelPhotoPageViewController") as! AddLabelPhotoPageViewController
            myVC.templateType = types[cellClicked]
            myVC.vcType = "Add"
            navigationController?.pushViewController(myVC, animated: true)
            
        } else if (indexPath.section == 2) {
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "AddLabelPageViewController") as! AddLabelPageViewController
            myVC.templateType = types[cellClicked]
            myVC.vcType = "Add"
            navigationController?.pushViewController(myVC, animated: true)

        } else {
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "AddPhotoPageViewController") as! AddPhotoPageViewController
            myVC.templateType = types[cellClicked]
            myVC.vcType = "Add"
            navigationController?.pushViewController(myVC, animated: true)
            
        }
        
    }
    
    func convertIndexPathToRow(indexPath: IndexPath) -> Int {
        
        if(indexPath.section == 0) {
            
            return indexPath.row
            
        } else if(indexPath.section == 1) {
            
            return indexPath.row + 4
            
        } else  {
            
            return indexPath.section + 6
            
        }
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
