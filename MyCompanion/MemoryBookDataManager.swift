//
//  MemoryBookDataManager.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 3/28/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MemoryBookDataManager {
    
    /**
        Gets current context so core data operations can be done
     
        - Returns: current context
     */
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    /**
        Returns pages from core data
     
        - Returns: array of core data objects
     */
    static func fetchPages() -> [NSManagedObject] {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MemoryBook")
        var pages : [NSManagedObject] = []
        
        do {
            pages = try context.fetch(fetchRequest)
            pages = pages.sorted(by: { $0.value(forKeyPath: "orderPosition") as! Int > $1.value(forKeyPath: "orderPosition") as! Int})
            return pages
        } catch _ as NSError {
            return []
        }
    }
    
    /**
        Deletes give page from core data
     
        - Parameter page: page to be deleted
     
        - Returns: bool of whether delete was succesful
     */
    static func deletePage(page: NSManagedObject) -> Bool {
        let context = getContext()
        context.delete(page)
        
        do {
            try context.save()
            return true
        } catch _ as NSError {
            return false
        }
    }
    
    /**
        Create new memory book page and save
     
        - Parameters:
            - title: title to be stored
            - text: text to be stored
            - templateType: template type to be stored
            - imageData: image data to be stored
            - videoID: videoID to be stored
     
        - Returns: bool of whether store was succesful
     */
    static func storePage(title: String!, text: String!, templateType: String!, imageData: NSData!, videoID: String!) -> Bool{
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "MemoryBook", in: context)
        let page = NSManagedObject(entity: entity!, insertInto: context)
        
        page.setValue(title, forKey: "title")
        page.setValue(text, forKey: "text")
        page.setValue(templateType, forKey: "templateType")
        page.setValue(imageData, forKey: "image")
        page.setValue(videoID, forKey: "videoID")
        
        do {
            try context.save()
            return true
        } catch _ as NSError {
            return false
        }
    }
    
    /**
        Update memory book page and save
     
        - Parameters:
            - page: core data object to be updated
            - title: title to be stored
            - text: text to be stored
            - templateType: template type to be stored
            - imageData: image data to be stored
            - videoID: videoID to be stored
     
        - Returns: bool of whether store was succesful
     */
    static func updatePage(page: NSManagedObject, title: String!, text: String!, templateType: String!, imageData: NSData!, videoID: String!) -> Bool{
        let context = getContext()
        
        page.setValue(title, forKey: "title")
        page.setValue(text, forKey: "text")
        page.setValue(templateType, forKey: "templateType")
        page.setValue(imageData, forKey: "image")
        page.setValue(videoID, forKey: "videoID")
        
        do {
            try context.save()
            return true
        } catch _ as NSError {
            return false
        }
    }

}
