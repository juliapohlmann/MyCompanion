//
//  EditContactViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 3/21/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import CoreData
import UIKit

class EditContactTableViewController: UITableViewController {
    
    var contacts: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setLeftBarButtonItems([self.editButtonItem], animated: false)
        
        contacts = ContactDataManager.fetchContacts()

    }
    
    // MARK: - Table view data source
    func dismiss(sender: AnyObject) {
        self.dismiss(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditContactCell", for: indexPath) as! EditContactTableViewCell
        let contact = contacts[indexPath.row]
        
        cell.name.text = contact.value(forKeyPath: "name") as? String
        return cell
        
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegue(withIdentifier: "editContactSegue", sender: self);

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let didDelete = ContactDataManager.deleteContact(contact: contacts[indexPath.row])
            
            if didDelete {
                contacts = ContactDataManager.fetchContacts()
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                print ("didnt delete!!")
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addContactSegue") {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! ContactDetailViewController
            targetController.type = "Add Contact"
        }
        else if (segue.identifier == "editContactSegue") {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! ContactDetailViewController
            targetController.type = "Edit Contact"
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let contact = contacts[indexPath.row]
                targetController.contact = contact
            }
        }
    }

    
}
