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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch(indexPath[1]) {
        case 1:
            self.performSegue(withIdentifier: "editMemoryBook", sender: self)
        case 2:
            self.performSegue(withIdentifier: "editContact", sender: self)
        case 3:
            self.performSegue(withIdentifier: "editReminders", sender: self)
        case 4:
            self.performSegue(withIdentifier: "caregiverTips", sender: self)
        default:
            self.performSegue(withIdentifier: "generalSettings", sender: self)
        }
    }
    
}
