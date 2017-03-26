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
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
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
    
    static func toggleReminder(reminder: NSManagedObject) -> Bool {
        //ADD COOD HERE
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
    
}
