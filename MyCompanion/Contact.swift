//
//  Contact.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 2/13/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation

class Contact {
    var name : String
    var relationship : String
    var phone : String
    var email : String
    
    init(name: String, relationship: String, phone: String, email: String) {
        self.name = name
        self.relationship = relationship
        self.phone = phone
        self.email = email
    }
}
