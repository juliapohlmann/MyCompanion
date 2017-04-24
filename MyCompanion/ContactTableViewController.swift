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
    let purpleColor = UIColor(red: 156/225, green: 39/255, blue: 176/255, alpha: 1.0)

//    let canCall = UserDefaults.standard.object(forKey: "canCall") as! Bool
//    let canEmail = UserDefaults.standard.object(forKey: "canEmail") as! Bool
//    let purpleColor = UIColor(red: 156/225, green: 39/255, blue: 176/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contacts = ContactDataManager.fetchContacts()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(contacts.count == 0) {
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            emptyLabel.text = "No contacts available. Enter a new contact in the Caregiver Portal."
            emptyLabel.textAlignment = .center
            
            tableView.separatorStyle  = .none
            tableView.backgroundView = emptyLabel
            tableView.alwaysBounceVertical = false
        }
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactTableViewCell
        let contact = contacts[indexPath.row]
        
        cell.name.text = contact.value(forKeyPath: "name") as? String
        cell.email.text = contact.value(forKeyPath: "email") as? String
        cell.number.text = contact.value(forKeyPath: "number") as? String
        cell.relationship.text = contact.value(forKeyPath: "relationship") as? String
        
        cell = setImage(cell: cell, contact: contact)
        formatNumber(cell: cell)
        formatEmail(cell: cell)
        
        return cell
    }
    
    func setImage(cell: ContactTableViewCell, contact: NSManagedObject) -> ContactTableViewCell {
        if(contact.value(forKeyPath: "image") == nil) {
            cell.contactImage.image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
        } else {
            cell.contactImage.image = UIImage(data: contact.value(forKeyPath: "image") as! Data)
        }
        return cell
    }
    
    func formatNumber(cell: ContactTableViewCell) {
        let canCall = UserDefaults.standard.object(forKey: "canCall") as! Bool

        if (canCall) {
            cell.number.textColor = purpleColor
        }
    }
    
    func formatEmail(cell: ContactTableViewCell) {
        let canEmail = UserDefaults.standard.object(forKey: "canEmail") as! Bool

        if (canEmail) {
            cell.email.textColor = purpleColor
        }
    }
    
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
