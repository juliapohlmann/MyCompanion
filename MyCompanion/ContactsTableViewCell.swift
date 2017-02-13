//
//  ContactsTableViewCell.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 2/13/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit



class ContactsTableViewCell: UITableViewCell {
    
    @IBOutlet var contactImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var relationLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    func setContact(contact: Contact) {
        nameLabel.text = contact.name
        relationLabel.text = contact.relationship
        phoneLabel.text = contact.phone
        emailLabel.text = contact.email
    }
}
