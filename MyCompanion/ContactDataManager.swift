//
//  ContactDataManager.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 3/22/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import CoreData
import UIKit

 class ContactDataManager {
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func fetchContacts() -> [NSManagedObject] {
        var contacts : [NSManagedObject] = []
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Contact")
        
        do {
            contacts = try context.fetch(fetchRequest)
            return contacts
        } catch _ as NSError {
            return []
//            let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
//            errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//            present(errorDialog, animated: true)
        }
    }
    
    static func storeContact(name: String, relationship: String, number: String, email: String/*, imageData: NSData*/) -> Bool {
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)
        let contact = NSManagedObject(entity: entity!, insertInto: context)
        
        contact.setValue(name, forKey: "name")
        contact.setValue(relationship, forKey: "relationship")
        contact.setValue(number, forKey: "number")
        contact.setValue(email, forKey: "email")
//        contact.setValue(imageData, forKey: "image")
        
        do {
            try context.save()
            return true
            
        } catch _ as NSError {
            return false
//            let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
//            errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//            present(errorDialog, animated: true)
        }
        
//        self.dismiss(animated: true)
    }
    
    static func deleteContact(contact: NSManagedObject) -> Bool {
        let context = getContext()
        context.delete(contact)
        
        do {
            try context.save()
            return true
        } catch _ as NSError {
            return false
        }

    }
}
