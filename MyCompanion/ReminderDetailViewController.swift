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
    
    /**
        Textfield delegate method when done editing
     
        - Parameter textField: text field to end editing
     
        - Returns: returns false always
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    /**
        If editing an existing reminder, load the reminder text
     
     */
    func loadReminder() {
        nameTextField.text = reminder?.value(forKeyPath: "text") as? String
    }
    
    /**
        Function that is called when save button is tapped
     
        - Parameter sender: button clicked
     */
    @IBAction func storeReminder(_ sender: Any) {
        if(checkInputValidity()) {
            let didSucceed = false
            if(type == "Add Reminder") {
                didSucceed = ReminderDataManager.storeReminder(reminderText: nameTextField.text!)
            } else if (type == "Edit Reminder") {
                didSucceed = ReminderDataManager.updateReminder(reminder: self.reminder!, reminderText: nameTextField.text!)
            }
            
            if(didSucceed) {
                performSegue(withIdentifier: "backToEditReminders", sender: self)
            } else {
                print("Problem updating/saving reminder")
            }
        }
    }
    
    /**
        Helper function that checks input values are valid
     
        - Returns: true if valid, false if not
     */
    func checkInputValidity() -> Bool {
        if(nameTextField.text! == "") {
            sendAlert(title: "MissingText", message: "Please enter text for the reminder")
            return false
        }
        return true
    }
    
    /**
        Presents UI Alert Controller if input is not valid
     
        - Parameter title: title of alert controller
        - Parameter message: message of alert controller
     */
    func sendAlert(title: String, message: String) {
        let controller : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(ok)
        present(controller, animated: true, completion: nil)
    }
}
