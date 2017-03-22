//
//  EditContactViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 3/21/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import CoreData
import UIKit

class EditContactTableViewController: UITableViewController {
    
    var contacts: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setLeftBarButtonItems([self.editButtonItem], animated: false)
        
        contacts = ContactDataManager.fetchContacts()

    }
    
    // MARK: - Table view data source
    func dismiss(sender: AnyObject) {
        self.dismiss(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        fetchContacts()
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditContactCell", for: indexPath) as! EditContactTableViewCell
        let contact = contacts[indexPath.row]
        
        cell.name.text = contact.value(forKeyPath: "name") as? String
        print("NAME: \(contact.value(forKeyPath: "name") as? String)")
//        cell.email.text = contact.value(forKeyPath: "email") as? String
//        cell.number.text = contact.value(forKeyPath: "number") as? String
//        cell.relationship.text = contact.value(forKeyPath: "relationship") as? String
//        cell.contactImage.image = UIImage(data: contact.value(forKeyPath: "image") as! Data)
        
        return cell
        
    }
    
//    func getContext() -> NSManagedObjectContext {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        return appDelegate.persistentContainer.viewContext
//    }
    
//    func fetchContacts() {
//        let context = getContext()
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Contact")
//        
//        do {
//            contacts = try context.fetch(fetchRequest)
//            print("SUCCESS")
//        } catch let error as NSError {
//            let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
//            errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//            present(errorDialog, animated: true)
//        }
//    }
    
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
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let didDelete = ContactDataManager.deleteContact(contact: contacts[indexPath.row])
            
            print(didDelete)
            
            if didDelete {
                contacts = ContactDataManager.fetchContacts()
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                //SHOW ERROR
                print ("didnt delete!!")
            }
//            let context = getContext()
//            context.delete(contacts[indexPath.row])
//            
//            do {
//                try context.save()
//            } catch let error as NSError {
//                let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
//                errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//                present(errorDialog, animated: true)
//            }
            
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
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
