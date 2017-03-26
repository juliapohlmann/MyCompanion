//
//  caregiverPortalTableViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 3/21/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit

class CaregiverPortalTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // method to run when table view cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Segue to the second view controller
        if(indexPath[1] == 2) {
            self.performSegue(withIdentifier: "editContact", sender: self)
        } else if (indexPath[1] == 1) {
            self.performSegue(withIdentifier: "editMemoryBook", sender: self)
        } else if (indexPath[1] == 3) {
            self.performSegue(withIdentifier: "editReminders", sender: self)
        } else if (indexPath[1] == 0) {
            self.performSegue(withIdentifier: "generalSettings", sender: self)
        } else if (indexPath[1] == 4) {
            self.performSegue(withIdentifier: "caregiverForum", sender: self)
        }
    }
    
}
