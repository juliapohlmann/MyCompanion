//
//  CaregiverTileViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 2/21/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit

class CaregiverTileViewController: UIViewController {
    
    @IBOutlet var caregiverImage: UIImageView!
    @IBOutlet var newWordField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        caregiverImage.image = UIImage.fontAwesomeIcon(name: .cog, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
    }
    
    /**
        Called when alert prompt is entered
     
        - Parameter alert: alert that was closed
     */
    func wordEntered(alert: UIAlertAction!){
        
        let originalPassword = UserDefaults.standard.object(forKey: "userPassword") as! String
        
        if(newWordField?.text == originalPassword) {
            showCaregiverPortal()
        } else {
            presentPrompt()
        }
    }
    
    /**
        Adds text field to alert controller
     
        - Parameter textField: text field to add to alert
     */
    func addTextField(textField: UITextField!){
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true

        self.newWordField = textField
    }
    
    /**
        present prompt when caregiver portal tile is clicked
     
        - Parameter sender: button clicked
     */
    @IBAction func caregiverPortalClick(_ sender: Any) {
        if(shouldPresentPrompt()) {
            presentPrompt()
        } else {
            showCaregiverPortal()
        }
    }
    
    func shouldPresentPrompt() -> Bool {
        return UserDefaults.standard.object(forKey: "passwordEnabled") as! Bool
    }
    
    /**
        Creates UI Alert Controller and shows it
     
     */
    func presentPrompt() {
        
        let newWordPrompt = UIAlertController(title: "Enter Password", message: "Please enter the caregiver password", preferredStyle: UIAlertControllerStyle.alert)
        newWordPrompt.addTextField(configurationHandler: addTextField)
        newWordPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        newWordPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: wordEntered))
        
        present(newWordPrompt, animated: true, completion: nil)
    }
    
    func showCaregiverPortal() {
        let caregiverPortal = storyboard!.instantiateViewController(withIdentifier: "caregiverPortalSplitViewController")
        self.present(caregiverPortal, animated: true, completion: nil)
    }
}
