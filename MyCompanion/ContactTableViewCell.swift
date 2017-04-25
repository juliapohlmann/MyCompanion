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
    
    //Purple color to change number/email to if calling/emailing enabled
    let PURPLE_COLOR = UIColor(red: 156/225, green: 39/255, blue: 176/255, alpha: 1.0)

    /**
        Function that is called when number field is tapped
        
        - Parameter sender: gesture recognizer
     */
    func tapNumber(sender:UITapGestureRecognizer) {
        let canCall = UserDefaults.standard.object(forKey: "canCall") as! Bool

        if(canCall && number.text != "") {
            if let url = NSURL(string: "tel://\(number.text!.replacingOccurrences(of: "-", with: ""))"), UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
    }
    
    /**
        Function that is called when email field is tapped
     
        - Parameter sender: gesture recognizer
     */
    func tapEmail(sender:UITapGestureRecognizer) {
        let canEmail = UserDefaults.standard.object(forKey: "canEmail") as! Bool
        if(canEmail && email.text != "") {
            if let url = URL(string: "mailto:\(email.text!)") {
                UIApplication.shared.open(url)
            }
        }
        
    }
    
    /**
        Helper function to make number field recognize gesture and change appearance
     */
    func enableCalling() {
        number.textColor = PURPLE_COLOR
        
        let tapNumber = UITapGestureRecognizer(target: self, action: #selector(ContactTableViewCell.tapNumber))
        number.isUserInteractionEnabled = true
        number.addGestureRecognizer(tapNumber)
    }
    
    /**
        Helper function to make email field recognize gesture and change appearance
     */
    func enableEmailing() {
        email.textColor = PURPLE_COLOR
        
        let tapEmail = UITapGestureRecognizer(target: self, action: #selector(ContactTableViewCell.tapEmail))
        email.isUserInteractionEnabled = true
        email.addGestureRecognizer(tapEmail)
    }

}
