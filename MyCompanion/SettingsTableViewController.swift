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
    
    @IBOutlet var showEmailsSwitch: UISwitch!
    @IBOutlet var showPhoneNumbersSwitch: UISwitch!
    @IBOutlet var enableCallingSwitch: UISwitch!
    @IBOutlet var enableEmailingSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let canCall = UserDefaults.standard.object(forKey: "canCall") as! Bool
        let canEmail = UserDefaults.standard.object(forKey: "canEmail") as! Bool
        let showPhoneNumbers = UserDefaults.standard.object(forKey: "showPhoneNumbers") as! Bool
        let showEmails = UserDefaults.standard.object(forKey: "showEmails") as! Bool
        
        enableCallingSwitch.setOn(canCall, animated: false)
        enableEmailingSwitch.setOn(canEmail, animated: false)
        showPhoneNumbersSwitch.setOn(showPhoneNumbers, animated: false)
        showEmailsSwitch.setOn(showEmails, animated: false)

    }
    
    @IBAction func toggleShowPhoneNumbers(_ sender: Any) {
        UserDefaults.standard.set(showPhoneNumbersSwitch.isOn, forKey: "showPhoneNumbers")
        UserDefaults.standard.synchronize()
        
        if(!showPhoneNumbersSwitch.isOn) {
            enableCallingSwitch.setOn(showPhoneNumbersSwitch.isOn, animated: true)
            toggleEnableCalling(self)
        }
    }
    
    @IBAction func toggleShowEmails(_ sender: Any) {
        UserDefaults.standard.set(showEmailsSwitch.isOn, forKey: "showEmails")
        UserDefaults.standard.synchronize()

        
        if(!showEmailsSwitch.isOn) {
            enableEmailingSwitch.setOn(showEmailsSwitch.isOn, animated: true)
            toggleEnableEmailing(self)
        }
    }
    
    @IBAction func toggleEnableCalling(_ sender: Any) {
        UserDefaults.standard.set(enableCallingSwitch.isOn, forKey: "canCall")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func toggleEnableEmailing(_ sender: Any) {
        UserDefaults.standard.set(enableEmailingSwitch.isOn, forKey: "canEmail")
        UserDefaults.standard.synchronize()
    }

    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        
        switch(section){
            
        case 0: return "Contacts Settings"
        default: return "mistake"
            
        }
    }


}
