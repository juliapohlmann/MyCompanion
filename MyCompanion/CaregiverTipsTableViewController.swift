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
    
    //Currently these values are hardcoded. These will be replaced soon after an programatic way for us to access the Caregiver tips released by the Alzheimer's Association through an API or some other means
    let numWB = 4
    let numC = 5
    let numB = 13
    let numDC = 3
    let numA = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        
        do {
            //READ in the JSON
            if let file = Bundle.main.url(forResource: "tips", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [Any] {
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
        cell.textLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        return cell
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch(section) {
        case 0:
            return numWB
        case 1:
            return numC
        case 2:
            return numB
        case 3:
            return numDC
        case 4:
            return numA
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
        case 0:
            return indexPath.row
        case 1:
            return indexPath.row + numWB
        case 2:
            return indexPath.row + numWB + numC
        case 3:
            return indexPath.row + numWB + numC + numB
        case 4:
            return indexPath.row + numWB + numC + numB + numDC
        default:
            return indexPath.row
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationNavigationController = segue.destination as! UINavigationController
        let targetController = destinationNavigationController.topViewController as! DisplayTipsViewController
        
        let indexPath = self.tableView.indexPathForSelectedRow
        let currentCellInfo = tips[convertIndexPathToRow(indexPath: indexPath!)] as NSDictionary
        
        targetController.text = (currentCellInfo["Info"] as? String)!
        targetController.tipTitle = (currentCellInfo["SubCat"] as? String)!
    }
}
