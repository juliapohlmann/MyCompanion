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
    let OneOnePtypes = 4
    let OneOneVtypes = 4
    let OneTtypes = 1
    let OnePtypes = 1
    let OneVtypes = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch(section){
        case 0: return OneOnePtypes
        case 1: return OneOneVtypes
        case 2: return OneTtypes
        case 3: return OnePtypes
        case 4: return OneVtypes
        default: return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        switch(section){
            case 0: return "1 Picture/Text"
            case 1: return "1 Video/Text"
            case 2: return "1 Text"
            case 3: return "1 Picture"
            case 4: return "1 Video"
            default: return "Error"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "templateType", for: indexPath) as! AddPageTableViewCell

        //cell.textLabel?.text = types[convertIndexPathToRow(indexPath: indexPath)]
        let fileName = types[convertIndexPathToRow(indexPath: indexPath)] + "_Fiverr.jpg"
        
        cell.templateImage!.image = UIImage(named: fileName)
        cell.templateImage!.layer.borderWidth = 1
        cell.templateImage!.layer.borderColor = UIColor.lightGray.cgColor
        
//        cell.imageView!.image = UIImage(named: fileName)
//        cell.imageView!.center = cell.center
        
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
    
    
    /**
        Helper function to convert given index path to a row number
        
        - Parameter indexPath: IndexPath to convert
     
        - Returns: int of row path corresponds to
     */
    func convertIndexPathToRow(indexPath: IndexPath) -> Int {
        
        if(indexPath.section == 0) {
            return indexPath.row
        } else if(indexPath.section == 1) {
            return indexPath.row + OneOnePtypes
        } else if(indexPath.section == 2) {
            return indexPath.row + OneOnePtypes + OneOneVtypes
        } else if(indexPath.section == 3) {
            return indexPath.row + OneOnePtypes + OneOneVtypes + OneTtypes
        } else {
            return indexPath.row + OneOnePtypes + OneOneVtypes + OneTtypes + OnePtypes
        }
    }

}
