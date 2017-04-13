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
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
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
