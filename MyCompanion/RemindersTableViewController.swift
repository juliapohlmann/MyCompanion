//
//  RemindersViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 3/5/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RemindersTableViewController: UITableViewController {
    
    @IBAction func homeClicked(_ sender: Any) {
        performSegue(withIdentifier: "remindersToHomeSegue", sender: sender)
    }
    
    var reminders = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "canCall")
        UserDefaults.standard.set(true, forKey: "canEmail")
        UserDefaults.standard.set(true, forKey: "showPhoneNumbers")
        UserDefaults.standard.set(true, forKey: "showEmails")
        reminders = ReminderDataManager.fetchReminders()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(reminders.count == 0) {
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            emptyLabel.text = "No reminders available. Enter a new reminder in the Caregiver Portal."
            emptyLabel.textAlignment = .center
            
            tableView.separatorStyle  = .none
            tableView.backgroundView = emptyLabel
            tableView.alwaysBounceVertical = false
        }
        return reminders.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RemindersTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RemindersTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
//        let reminderText = reminders[indexPath.row].value(forKeyPath: "text") as? String
        cell.setReminder(reminder: reminders[indexPath.row])
        
        return cell
    }
    
    
    
}

