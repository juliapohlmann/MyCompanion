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

class ReminderDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var nameTextField: JiroTextField!
    
    var reminder : NSManagedObject?
    var type : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(type == "Edit Reminder") {
            loadReminder()
        }
        self.navigationItem.title = self.type

        nameTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func loadReminder() {
        nameTextField.text = reminder?.value(forKeyPath: "text") as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func storeReminder(_ sender: Any) {
        if(checkInputValidity()) {
            //ADD CHECK FOR REMINDER FORMAT
            if(type == "Add Reminder") {
                _ = ReminderDataManager.storeReminder(reminderText: nameTextField.text!)
            } else if (type == "Edit Reminder") {
                _ = ReminderDataManager.updateReminder(reminder: self.reminder!, reminderText: nameTextField.text!)
            }
            performSegue(withIdentifier: "backToEditReminders", sender: self)
        }
    }
    
    func checkInputValidity() -> Bool {
        if(nameTextField.text! == "") {
            sendAlert(title: "MissingText", message: "Please enter text for the reminder")
            return false
        }
        return true
    }
    
    func sendAlert(title: String, message: String) {
        let controller : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(ok)
        present(controller, animated: true, completion: nil)
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
