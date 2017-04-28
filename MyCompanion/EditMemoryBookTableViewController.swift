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
            if MemoryBookDataManager.deletePage(page: pages[indexPath.row]) {
                pages = MemoryBookDataManager.fetchPages()
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = self.tableView.indexPathForSelectedRow!
        let page : NSManagedObject = pages[indexPath.row]
        let pageType = page.value(forKeyPath: "templateType") as? String
        
        if(pageType?.hasPrefix("11"))! {
            let myVC = storyboard?.instantiateViewController(withIdentifier: "DetailLabelPhotoPageViewController") as! DetailLabelPhotoPageViewController
            myVC.templateType = pageType!
            myVC.vcType = "Edit Page"
            myVC.page = pages[indexPath.row]
            navigationController?.pushViewController(myVC, animated: true)
            
        } else if (pageType!.hasSuffix("T")) {
            let myVC = storyboard?.instantiateViewController(withIdentifier: "DetailLabelPageViewController") as! DetailLabelPageViewController
            myVC.templateType = pageType!
            myVC.vcType = "Edit Page"
            myVC.page = pages[indexPath.row]
            navigationController?.pushViewController(myVC, animated: true)
            
        } else {
            let myVC = storyboard?.instantiateViewController(withIdentifier: "DetailPhotoPageViewController") as! DetailPhotoPageViewController
            myVC.templateType = pageType!
            myVC.vcType = "Edit Page"
            myVC.page = pages[indexPath.row]
            navigationController?.pushViewController(myVC, animated: true)
            
        }
    }
}
