//
//  ReminderTileViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 3/5/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit

class ReminderTileViewController : UIViewController {
    
    @IBOutlet var remindersLabel: UIButton!
    @IBOutlet var remindersImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remindersImage.image = UIImage.fontAwesomeIcon(name: .list, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
    }
    
//    @IBAction func contactClick(_ sender: Any) {
//        performSegue(withIdentifier: "contactTileToContactPageSegue", sender: sender)
//    }
    
}
