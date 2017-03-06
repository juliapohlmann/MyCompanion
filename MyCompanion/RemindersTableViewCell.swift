//
//  RemindersTableViewCell.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 3/5/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit


class RemindersTableViewCell: UITableViewCell {
    
    @IBOutlet var reminderLabel: UILabel!
    
    
    func setReminder(reminder: Reminder) {
        self.reminderLabel.text = reminder.text
    }
}
