//
//  AddRemindersViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/21/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import CoreData
import TextFieldEffects

class AddReminderViewController: UIViewController {

    @IBOutlet var nameTextField: JiroTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func storeReminder(_ sender: Any) {
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Reminder", in: context)
        let contact = NSManagedObject(entity: entity!, insertInto: context)
        
        contact.setValue(nameTextField.text, forKey: "text")
        
        do {
            
            try context.save()
            
        } catch _ as NSError {
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
