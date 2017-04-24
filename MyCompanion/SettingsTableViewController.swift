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


}
