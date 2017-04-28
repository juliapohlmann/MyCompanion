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
    
    @IBAction func reminderClick(_ sender: Any) {
        let reminderVC = storyboard!.instantiateViewController(withIdentifier: "reminderTableViewController")
        self.present(reminderVC, animated: true, completion: nil)
//        performSegue(withIdentifier: "reminderTileToReminderPageSegue", sender: sender)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remindersImage.image = UIImage.fontAwesomeIcon(name: .list, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
    }
    
    
}
