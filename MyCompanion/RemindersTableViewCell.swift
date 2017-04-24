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
    var reminderText : String = ""
    @IBOutlet var checkbox: CheckboxControl!
    @IBOutlet var reminderLabel: UILabel!
    
    func setReminder(reminder: NSManagedObject) {
        self.reminder = reminder
        self.reminderText = (reminder.value(forKeyPath: "text") as? String)!
        let isChecked = (reminder.value(forKeyPath: "completed") as? Bool)!
        self.checkbox.isSelected = isChecked
        setText(striked: isChecked)

    }
    
    func setText(striked: Bool) {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: reminderText)
        if(striked) {
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        }
        reminderLabel.attributedText = attributeString

    }
    
    
    @IBAction func onClick(_ sender: Any) {
//        let didToggle = ReminderDataManager.toggleReminder(reminder: reminder!)
        setText(striked: checkbox.isSelected)

    }
}
