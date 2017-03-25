//
//  MemoryBookTableViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/17/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import CoreData

class MemoryBookTableViewController: UITableViewController {

    var pages: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        fetchPages()
        
        return pages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pagesCell", for: indexPath)
        let page = pages[indexPath.row]
        
        cell.textLabel?.text = page.value(forKeyPath: "title") as? String
        
        return cell
        
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func fetchPages() {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MemoryBook")
        
        do {
            pages = try context.fetch(fetchRequest)
            pages = pages.sorted(by: { $0.value(forKeyPath: "orderPosition") as! Int > $1.value(forKeyPath: "orderPosition") as! Int})
        } catch let error as NSError {
            let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
            errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(errorDialog, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let context = getContext()
            context.delete(pages[indexPath.row])
            
            do {
                try context.save()
            } catch let error as NSError {
                let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
                errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                present(errorDialog, animated: true)
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let context = getContext()
        
        do {
            try context.save()
        } catch let error as NSError {
            let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
            errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(errorDialog, animated: true)
        }
        
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
