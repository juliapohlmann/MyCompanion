//
//  SettingsTableViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 2/21/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import FontAwesome_swift

class SettingsTableViewController: UITableViewController {

    @IBOutlet var callsSwitch: UISwitch!
    @IBOutlet var emailsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let canCall = UserDefaults.standard.object(forKey: "canCall") as! Bool
        let canEmail = UserDefaults.standard.object(forKey: "canEmail") as! Bool
        
        callsSwitch.setOn(canCall, animated: false)
        emailsSwitch.setOn(canEmail, animated: false)
    }

    @IBAction func callsValueChanged(_ sender: Any) {
        
        UserDefaults.standard.set(callsSwitch.isOn, forKey: "canCall")
        UserDefaults.standard.synchronize()
        
    }
    
    @IBAction func emailsValueChanged(_ sender: Any) {
        
        UserDefaults.standard.set(emailsSwitch.isOn, forKey: "canEmail")
        UserDefaults.standard.synchronize()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        
        switch(section){
            
        case 0: return "Contacts Settings"
        default: return "mistake"
            
        }
        
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
