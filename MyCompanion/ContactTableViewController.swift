//
//  ContactTableViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 3/21/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ContactTableViewController: UITableViewController {
    @IBOutlet var homeButton: UIButton!
    var contacts: [NSManagedObject] = []
    let canCall = UserDefaults.standard.object(forKey: "canCall") as! Bool
    let canEmail = UserDefaults.standard.object(forKey: "canEmail") as! Bool
    let purpleColor = UIColor(red: 156/225, green: 39/255, blue: 176/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contacts = ContactDataManager.fetchContacts()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactTableViewCell
        let contact = contacts[indexPath.row]
        
        cell.name.text = contact.value(forKeyPath: "name") as? String
        cell.email.text = contact.value(forKeyPath: "email") as? String
        if(canEmail) {
            
            cell.email.textColor = purpleColor
            
        }
        cell.number.text = contact.value(forKeyPath: "number") as? String
        if(canCall) {
            
            cell.number.textColor = purpleColor
            
        }
        cell.relationship.text = contact.value(forKeyPath: "relationship") as? String
        if(contact.value(forKeyPath: "image") == nil) {
            cell.contactImage.image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
        } else {
            cell.contactImage.image = UIImage(data: contact.value(forKeyPath: "image") as! Data)
        }
        //cell.contactImage.image = UIImage(data: contact.value(forKeyPath: "image") as! Data)
        
        return cell
        
    }
    
//    func getContext() -> NSManagedObjectContext {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        return appDelegate.persistentContainer.viewContext
//    }
//    
//    func fetchContacts() {
//        let context = getContext()
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Contact")
//        
//        do {
//            contacts = try context.fetch(fetchRequest)
//        } catch let error as NSError {
//            let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
//            errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//            present(errorDialog, animated: true)
//        }
//    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let context = getContext()
//            context.delete(contacts[indexPath.row])
//            
//            do {
//                try context.save()
//            } catch let error as NSError {
//                let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
//                errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//                present(errorDialog, animated: true)
//            }
//            
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }

    
}
