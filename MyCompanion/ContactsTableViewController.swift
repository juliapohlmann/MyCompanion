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
    
    
    
    private func loadSampleContacts() {
        contacts.append(Contact("Julia", "Friend", "550-019-1289", "blah@blah"))
        contacts.append(Contact("Shyam", "Buddy", "128-129-3046", "aldk@aldk"))
    }
    
}
