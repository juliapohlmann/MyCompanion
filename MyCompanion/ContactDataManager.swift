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
    
    /**
        Gets current context so core data operations can be done
     
        - Returns: current context
     */
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    /**
        Returns contacts from core data
     
        - Returns: array of core data objects
     */
    static func fetchContacts() -> [NSManagedObject] {
        var contacts : [NSManagedObject] = []
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Contact")
        
        do {
            contacts = try context.fetch(fetchRequest)
            return contacts
        } catch _ as NSError {
            return []
        }
    }
    
    /**
        Create new contact data
     
        - Parameters: 
            - name: name to be stored
            - relationship: relationship to be stored
            - number: number to be stored
            - email: email to be stored
            - imageData: image data to be stored
     
        - Returns: bool of whether store was succesful
     */
    static func storeContact(name: String, relationship: String, number: String!, email: String!, imageData: NSData!) -> Bool {
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)
        let contact = NSManagedObject(entity: entity!, insertInto: context)
        
        contact.setValue(name, forKey: "name")
        contact.setValue(relationship, forKey: "relationship")
        contact.setValue(number, forKey: "number")
        contact.setValue(email, forKey: "email")
        contact.setValue(imageData, forKey: "image")
        
        do {
            try context.save()
            return true
            
        } catch _ as NSError {
            return false
        }
    }
    
    /**
        Deletes contact from core data
        
        - Parameter contact: contact to be deleted
     
        - Returns: bool of whether delete was succesful
     */
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
    
    /**
        Updates contact info of give contact
     
        - Parameters:
            - contact: data object to be updated
            - name: name to be stored
            - relationship: relationship to be stored
            - number: number to be stored
            - email: email to be stored
            - imageData: image data to be stored
     
        - Returns: bool of whether save was succesful
     */
    static func updateContact(contact: NSManagedObject, name: String, relationship: String, number: String!, email: String!, imageData: NSData!) -> Bool {
        let context = getContext()

        contact.setValue(name, forKey: "name")
        contact.setValue(relationship, forKey: "relationship")
        contact.setValue(number, forKey: "number")
        contact.setValue(email, forKey: "email")
        contact.setValue(imageData, forKey: "image")
        
        do {
            try context.save()
            return true
            
        } catch _ as NSError {
            return false
        }
    }
}
