//
//  RemindersViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 3/5/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit

class RemindersTableViewController: UITableViewController {
    
   /* @IBAction func homeClicked(_ sender: Any) {
        performSegue(withIdentifier: "contactsToHomeSegue", sender: sender)
    }
    */
    
    var reminders = [Reminder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleReminders()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RemindersTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RemindersTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.setReminder(reminder: reminders[indexPath.row])
        
        return cell
    }
    
    
    private func loadSampleReminders() {
        reminders.append(Reminder(text: "rem1"))
        reminders.append(Reminder(text: "rem2"))
        reminders.append(Reminder(text: "rem2"))
        reminders.append(Reminder(text: "rem2"))
    }
    
}

