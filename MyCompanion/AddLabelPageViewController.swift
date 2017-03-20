//
//  AddLabelPageViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/19/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import CoreData
import TextFieldEffects

class AddLabelPageViewController: UIViewController {

    var templateType: String? = nil
    @IBOutlet var titleTextField: JiroTextField!
    @IBOutlet var textTextField: JiroTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Core Data
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func storePage() {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "MemoryBook", in: context)
        let mb = NSManagedObject(entity: entity!, insertInto: context)
        
        mb.setValue(titleTextField.text, forKey: "title")
        mb.setValue(textTextField.text, forKey: "text")
        mb.setValue(templateType, forKey: "templateType")
        
        // popup errors!
        //        if(!isValidEmail(testStr: emailTextField.text!)) {
        //            print("not valid email")
        //        }
        //        else if(!isValidNumber(value: numberTextField.text!)) {
        //            print("not valid number")
        //        }
        //        else if(imageData == nil) {
        //            print("no picture")
        //        }
        //        else {
        
        do {
            try context.save()
        } catch let error as NSError {
            let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
            errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(errorDialog, animated: true)
        }
        
        self.dismiss(animated: true)
        
        //}
        
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
