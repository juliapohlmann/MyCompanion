//
//  NewRemindersTableViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/21/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import CoreData

class EditRemindersTableViewController: UITableViewController {

    var reminders : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setLeftBarButtonItems([self.editButtonItem], animated: false)

        reminders = ReminderDataManager.fetchReminders()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminder", for: indexPath)

        cell.textLabel?.text = reminders[indexPath.row].value(forKeyPath: "text") as? String

        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegue(withIdentifier: "editReminderSegue", sender: self);
        
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let didDelete = ReminderDataManager.deleteReminder(reminder: reminders[indexPath.row])
            
            if didDelete {
                reminders = ReminderDataManager.fetchReminders()
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                print("Didnt delete!")
            }
        }
    }
 
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addReminderSegue") {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! ReminderDetailViewController
            targetController.type = "Add Reminder"
        }
        else if (segue.identifier == "editReminderSegue") {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! ReminderDetailViewController
            
            targetController.type = "Edit Reminder"
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let reminder = reminders[indexPath.row]
                targetController.reminder = reminder
            }
        }
    }

}
