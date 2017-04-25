//
//  ReminderDataManager.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 3/25/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ReminderDataManager {
    
    /**
        Gets current context so core data operations can be done
     
        - Returns: current context
     */
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    /**
        Returns reminders from core data
     
        - Returns: array of core data objects
     */
    static func fetchReminders() -> [NSManagedObject] {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Reminder")
        
        do {
            let reminders = try context.fetch(fetchRequest)
            return reminders
        } catch _ as NSError {
            return []
        }
    }
    
    /**
        Create new contact and save text
     
        - Parameter reminderText: text to store
     
        - Returns: bool of whether store was succesful
     */
    static func storeReminder(reminderText: String) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Reminder", in: context)
        let reminder = NSManagedObject(entity: entity!, insertInto: context)
        
        reminder.setValue(reminderText, forKey: "text")
        reminder.setValue(false, forKey: "completed")

        do {
            try context.save()
            return true
        } catch _ as NSError {
            return false
        }
    }
    
    /**
        Update text of existing reminder
     
        - Parameter reminder: reminder to update
        - Parameter reminderText: text to store
     
        - Returns: bool of whether update was succesful
     */
    static func updateReminder(reminder: NSManagedObject, reminderText: String) -> Bool {
        let context = getContext()
        
        reminder.setValue(reminderText, forKey: "text")
        
        do {
            try context.save()
            return true
        } catch _ as NSError {
            return false
        }
    }
    
    /**
        Toggles value of completed for reminder
     
        - Parameter reminder: reminder to toggle value of
     
        - Returns: bool of whether toggle was succesful
     */
    static func toggleReminder(reminder: NSManagedObject) -> Bool {
        let context = getContext()
        
        let currentValue = reminder.value(forKey: "completed") as! Bool
        reminder.setValue(!currentValue, forKey: "completed")
        
        do {
            try context.save()
            return true
        } catch _ as NSError {
            return false
        }
    }
    
    /**
        Deletes reminder from core data
     
        - Parameter reminder: reminder to be deleted
     
        - Returns: bool of whether delete was succesful
     */
    static func deleteReminder(reminder: NSManagedObject) -> Bool {
        let context = getContext()
        context.delete(reminder)
        
        do {
            try context.save()
            return true
        } catch _ as NSError {
            return false
        }
        
    }
    
    /**
        Toggles a reminders value to false
     
        - Parameter reminder: reminder to be toggled
     
        - Returns: bool of whether value change was succesful
     */
    static func resetReminder(reminder: NSManagedObject) -> Bool {
        let context = getContext()
        
        reminder.setValue(false, forKey: "completed")
        
        do {
            try context.save()
            return true
        } catch _ as NSError {
            return false
        }
    }
    
    /**
        Resets all completed values to false
     
        - Returns: bool of whether values change was succesful
     */
    static func resetAllReminders() -> Bool {
        let reminders = fetchReminders()
        var didSucceed = false
        for reminder in reminders {
            let result = resetReminder(reminder: reminder)
            if (!result) {
                didSucceed = result
            }
        }
        
        return didSucceed
        
    }
    
}
