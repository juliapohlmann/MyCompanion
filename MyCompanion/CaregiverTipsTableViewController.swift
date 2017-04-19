//
//  CaregiverTipsTableViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 4/18/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit

class CaregiverTipsTableViewController: UITableViewController {
    
    var tips:[NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        
        do {
            if let file = Bundle.main.url(forResource: "tips", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [Any] {
                    // json is an array
                    tips = object as! [NSDictionary]
                    self.tableView.reloadData()
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentCellInfo = tips[convertIndexPathToRow(indexPath: indexPath)] as NSDictionary
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "caregiverTipsCell")!
        cell.textLabel?.text = currentCellInfo["SubCat"] as? String
        return cell
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch(section) {
        case 0:
            return 4
        case 1:
            return 5
        case 2:
            return 13
        case 3:
            return 3
        case 4:
            return 4
        default: return 0
        }

    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        
        switch(section){
            
        case 0: return "Well-Being"
        case 1: return "Communication"
        case 2: return "Behaviors"
        case 3: return "Daily Care"
        default: return "Activities"
            
        }
        
    }
    
    func convertIndexPathToRow(indexPath: IndexPath) -> Int {
        
        switch(indexPath.section){
            
        case 0: return indexPath.row
        case 1: return indexPath.row + 4
        case 2: return indexPath.row + 9
        case 3: return indexPath.row + 22
        case 4: return indexPath.row + 25
        default: return indexPath.row
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextScene = segue.destination as? DisplayTipsViewController
        let indexPath = self.tableView.indexPathForSelectedRow
        let currentCellInfo = tips[convertIndexPathToRow(indexPath: indexPath!)] as NSDictionary
        
        nextScene?.text = (currentCellInfo["Info"] as? String)!

    }
    
    
}
