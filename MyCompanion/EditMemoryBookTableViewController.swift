//
//  MemoryBookTableViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/17/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import CoreData

class EditMemoryBookTableViewController: UITableViewController {

    var pages: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pages = MemoryBookDataManager.fetchPages()
        
//        let back : UIBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismiss(sender:)))
        
        self.navigationItem.setLeftBarButtonItems([self.editButtonItem], animated: false)
    }
    
    // MARK: - Table view data source
    
    func dismiss(sender: AnyObject) {
        
        self.dismiss(animated: true)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pagesCell", for: indexPath)
        let page = pages[indexPath.row]
        
        cell.textLabel?.text = page.value(forKeyPath: "title") as? String
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let didDelete = MemoryBookDataManager.deletePage(page: pages[indexPath.row])
            if didDelete {
                pages = MemoryBookDataManager.fetchPages()
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                print("didnt delete!")
            }
        }
    }
    
    var types = ["11LP", "11RP", "11TP", "11DP", "11LV", "11RV", "11TV", "11DV", "1T", "1P", "1V"]

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellClicked:Int = convertIndexPathToRow(indexPath: indexPath)
        
        if(indexPath.section == 0 || indexPath.section == 1) {
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "DetailLabelPhotoPageViewController") as! DetailLabelPhotoPageViewController
            myVC.templateType = types[cellClicked]
            myVC.vcType = "Edit Page"
            myVC.page = pages[indexPath.row]
            navigationController?.pushViewController(myVC, animated: true)
            
        } else if (indexPath.section == 2) {
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "DetailLabelPageViewController") as! DetailLabelPageViewController
            myVC.templateType = types[cellClicked]
            myVC.vcType = "Edit Page"
            myVC.page = pages[indexPath.row]
            navigationController?.pushViewController(myVC, animated: true)
            
        } else {
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "DetailPhotoPageViewController") as! DetailPhotoPageViewController
            myVC.templateType = types[cellClicked]
            myVC.vcType = "Edit Page"
            myVC.page = pages[indexPath.row]
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
    
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//        
//        let context = getContext()
//        
//        do {
//            try context.save()
//        } catch let error as NSError {
//            let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
//            errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//            present(errorDialog, animated: true)
//        }
//        
//    }
    


}
