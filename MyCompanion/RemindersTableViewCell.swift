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
    
    /**
        Takes reminder data object, and sets cells fields to values of that data object
     
        - Parameter reminder: reminder to set cell values with
     
     */
    func setReminder(reminder: NSManagedObject) {
        self.reminder = reminder
        
        self.reminderText = (reminder.value(forKeyPath: "text") as? String)!
        let isChecked = (reminder.value(forKeyPath: "completed") as? Bool)!
        self.checkbox.isSelected = isChecked
        setText(striked: isChecked)
    }
    
    /**
        Helper function to set text as striked when the reminder is completed
     
        - Parameter striked: true if text should be striked
     
     */
    func setText(striked: Bool) {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: reminderText)
        
        if(striked) {
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        }
        
        reminderLabel.attributedText = attributeString
    }
    
    /**
        When checkbox is clicked, toggle completed value of the reminder
     
        - Parameter sender = checkbox clicked
     
     */
    @IBAction func onClick(_ sender: Any) {
        let didToggle = ReminderDataManager.toggleReminder(reminder: reminder!)
        
        if(didToggle) {
            setText(striked: checkbox.isSelected)
        } else {
            checkbox.isSelected = false
            print("Problem toggling reminder")
        }
    }
}
