//
//  ContactTileViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 2/13/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit

class ContactTileViewController : UIViewController {
    
    @IBOutlet var contactsImage: UIImageView!
    
    @IBAction func contactClick(_ sender: Any) {
        performSegue(withIdentifier: "contactTileToContactPageSegue", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactsImage.image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
    }
}
