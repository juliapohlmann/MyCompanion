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
    
    func wordEntered(alert: UIAlertAction!){
        
        let originalPassword = UserDefaults.standard.object(forKey: "userPassword") as! String
        
        if(newWordField?.text == originalPassword) {
            
            performSegue(withIdentifier: "caregiverTileToCaregiverPageSegue", sender: self)
            
        } else {
            
            presentPrompt()
            
        }
        
    }
    
    func addTextField(textField: UITextField!){
        // add the text field and make the result global
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true

        self.newWordField = textField
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        caregiverImage.image = UIImage.fontAwesomeIcon(name: .cog, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
    }
    
    @IBAction func caregiverPortalClick(_ sender: Any) {
        
        presentPrompt()
        
    }
    
    func presentPrompt() {
        
        let newWordPrompt = UIAlertController(title: "Enter Password", message: "Please enter the caregiver password", preferredStyle: UIAlertControllerStyle.alert)
        newWordPrompt.addTextField(configurationHandler: addTextField)
        newWordPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        newWordPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: wordEntered))
        
        present(newWordPrompt, animated: true, completion: nil)
        
        
    }
}
