//
//  ContactTableViewCell.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/15/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var relationship: UILabel!
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
