//
//  RemindersTableViewCell.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 3/5/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit
import DOCheckboxControl
import CoreData

class RemindersTableViewCell: UITableViewCell {
    
    var reminder : NSManagedObject?
    @IBOutlet var checkbox: CheckboxControl!
    @IBOutlet var reminderLabel: UILabel!
    
    func setReminder(reminder: NSManagedObject) {
        self.reminder = reminder
        self.reminderLabel.text = reminder.value(forKeyPath: "text") as? String
        self.checkbox.isSelected = (reminder.value(forKeyPath: "completed") as? Bool)!
    }
    
    
    @IBAction func onClick(_ sender: Any) {
        print("before CLICKED for \(reminder)")
        ReminderDataManager.toggleReminder(reminder: reminder!)
        print("after CLICKED for \(reminder)")

    }
}
