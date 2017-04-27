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
    
    @IBOutlet var resetRemindersDailySwitch: UISwitch!
    
    @IBOutlet var enablePasswordSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSwitchValues()
    }
    
    /**
        Helper function to get user defaults and set switches to those values
     
     */
    func setSwitchValues() {
        let canCall = UserDefaults.standard.object(forKey: "canCall") as! Bool
        let canEmail = UserDefaults.standard.object(forKey: "canEmail") as! Bool
        let showPhoneNumbers = UserDefaults.standard.object(forKey: "showPhoneNumbers") as! Bool
        let showEmails = UserDefaults.standard.object(forKey: "showEmails") as! Bool
        
        let resetRemindersDaily = UserDefaults.standard.object(forKey: "resetRemindersDaily") as! Bool
        
        let passwordEnabled = UserDefaults.standard.object(forKey: "passwordEnabled") as! Bool

        
        enableCallingSwitch.setOn(canCall, animated: false)
        enableEmailingSwitch.setOn(canEmail, animated: false)
        showPhoneNumbersSwitch.setOn(showPhoneNumbers, animated: false)
        showEmailsSwitch.setOn(showEmails, animated: false)
        enablePasswordSwitch.setOn(passwordEnabled, animated: false)
        
        resetRemindersDailySwitch.setOn(resetRemindersDaily, animated: false)
    }
    
    // MARK: - UISwitch functions
    
    /**
        When show phone number switch value is changed, change user defualt value
     
        - Parameter sender: toggled switch
     
     */
    @IBAction func toggleShowPhoneNumbers(_ sender: Any) {
        UserDefaults.standard.set(showPhoneNumbersSwitch.isOn, forKey: "showPhoneNumbers")
        UserDefaults.standard.synchronize()
        
        //if switched to off, make sure enable calling is switched off too
        if(!showPhoneNumbersSwitch.isOn) {
            enableCallingSwitch.setOn(showPhoneNumbersSwitch.isOn, animated: true)
            toggleEnableCalling(self)
        }
    }
    
    /**
        When show email switch value is changed, change user defualt value
     
        - Parameter sender: toggled switch
     
     */
    @IBAction func toggleShowEmails(_ sender: Any) {
        UserDefaults.standard.set(showEmailsSwitch.isOn, forKey: "showEmails")
        UserDefaults.standard.synchronize()
        
        //if switched to off, make sure enable emailing is switched off too
        if(!showEmailsSwitch.isOn) {
            enableEmailingSwitch.setOn(showEmailsSwitch.isOn, animated: true)
            toggleEnableEmailing(self)
        }
    }
    
    /**
        When enable calling switch value is changed, change user defualt value
     
        - Parameter sender: toggled switch
     
     */
    @IBAction func toggleEnableCalling(_ sender: Any) {
        UserDefaults.standard.set(enableCallingSwitch.isOn, forKey: "canCall")
        UserDefaults.standard.synchronize()
    }
    
    /**
        When enable email switch value is changed, change user defualt value
     
        - Parameter sender: toggled switch
     
     */
    @IBAction func toggleEnableEmailing(_ sender: Any) {
        UserDefaults.standard.set(enableEmailingSwitch.isOn, forKey: "canEmail")
        UserDefaults.standard.synchronize()
    }
    
    /**
        When reset reminders daily switch value is changed, change user defualt value
     
        - Parameter sender: toggled switch
     */
    @IBAction func toggleResetRemindersDaily(_ sender: Any) {
        UserDefaults.standard.set(resetRemindersDailySwitch.isOn, forKey: "resetRemindersDaily")
        UserDefaults.standard.synchronize()
    }
    
    
    @IBAction func toggleEnablePassword(_ sender: Any) {
        UserDefaults.standard.set(enablePasswordSwitch.isOn, forKey: "passwordEnabled")
        UserDefaults.standard.synchronize()
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch(section){
        case 0:
            return "Contacts Settings"
        case 1:
            return "Reminders Settings"
        case 2:
            return "Security Settings"
        default:
            return "mistake"
        }
    }


}
