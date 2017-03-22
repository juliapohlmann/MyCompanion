//
//  ContactTableViewCell1.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 3/22/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet var relationship: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var contactImage: UIImageView!
    @IBOutlet var number: UILabel!
    @IBOutlet var email: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
