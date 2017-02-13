//
//  ContactsTableViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 2/13/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit

class ContactsTableViewController: UITableViewController {
    
    @IBAction func homeClicked(_ sender: Any) {
        performSegue(withIdentifier: "contactsToHomeSegue", sender: sender)
    }
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleContacts()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ContactsTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ContactsTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.setContact(contact: contacts[indexPath.row])
        
        return cell
    }
    
    
    private func loadSampleContacts() {
        contacts.append(Contact(name: "Julia", relationship: "Friend", phone: "550-019-1289", email: "blah@blah"))
        contacts.append(Contact(name: "Shyam", relationship: "Buddy", phone: "128-129-3046", email: "aldk@aldk"))
        contacts.append(Contact(name: "Nisha", relationship: "Friend", phone: "550-019-1289", email: "blah@blah"))
        contacts.append(Contact(name: "Heidi", relationship: "Buddy", phone: "128-129-3046", email: "aldk@aldk"))

    }
    
}
