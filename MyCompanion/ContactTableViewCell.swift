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
        
        let tapNumber = UITapGestureRecognizer(target: self, action: #selector(ContactTableViewCell.tapNumber))
        number.isUserInteractionEnabled = true
        number.addGestureRecognizer(tapNumber)
        
        let tapEmail = UITapGestureRecognizer(target: self, action: #selector(ContactTableViewCell.tapEmail))
        email.isUserInteractionEnabled = true
        email.addGestureRecognizer(tapEmail)
    }
    
    func tapNumber(sender:UITapGestureRecognizer) {
        let canCall = UserDefaults.standard.object(forKey: "canCall") as! Bool

        if(canCall && number.text != "") {
            if let url = NSURL(string: "tel://\(number.text!.replacingOccurrences(of: "-", with: ""))"), UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func tapEmail(sender:UITapGestureRecognizer) {
        let canEmail = UserDefaults.standard.object(forKey: "canEmail") as! Bool
        if(canEmail && email.text != "") {
            if let url = URL(string: "mailto:\(email.text!)") {
                UIApplication.shared.open(url)
            }
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
