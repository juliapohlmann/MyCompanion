//
//  AddMemoryTableViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/17/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit

class AddPageTableViewController: UITableViewController {

    var types = ["11LP", "11RP", "11TP", "11DP", "11LV", "11RV", "11TV", "11DV", "1T", "1P", "1V"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0 || section == 1) {
            return 4
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {

        switch(section){
            
            case 0: return "1 text, 1 pic"
            case 1: return "1 text, 1 vid"
            case 2: return "1 text"
            case 3: return "1 pic"
            case 4: return "1 vid"
            default: return "mistake"
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "templateType", for: indexPath)

        cell.textLabel?.text = types[convertIndexPathToRow(indexPath: indexPath)]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellClicked:Int = convertIndexPathToRow(indexPath: indexPath)
        
        if(indexPath.section == 0 || indexPath.section == 1) {
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "DetailLabelPhotoPageViewController") as! DetailLabelPhotoPageViewController
            myVC.templateType = types[cellClicked]
            myVC.vcType = "Add Page"
            navigationController?.pushViewController(myVC, animated: true)
            
        } else if (indexPath.section == 2) {
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "DetailLabelPageViewController") as! DetailLabelPageViewController
            myVC.templateType = types[cellClicked]
            myVC.vcType = "Add Page"
            navigationController?.pushViewController(myVC, animated: true)

        } else {
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "DetailPhotoPageViewController") as! DetailPhotoPageViewController
            myVC.templateType = types[cellClicked]
            myVC.vcType = "Add Page"
            navigationController?.pushViewController(myVC, animated: true)
            
        }
        
    }
    
    func convertIndexPathToRow(indexPath: IndexPath) -> Int {
        
        if(indexPath.section == 0) {
            
            return indexPath.row
            
        } else if(indexPath.section == 1) {
            
            return indexPath.row + 4
            
        } else  {
            
            return indexPath.section + 6
            
        }
        
    }

}
