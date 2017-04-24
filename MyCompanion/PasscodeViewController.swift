//
//  PasscodeViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 2/19/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import TextFieldEffects

class PasscodeViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var passwordField: UITextField!
    var password = ""
    var confirmed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordField.delegate = self
        passwordField.becomeFirstResponder()
        
        UserDefaults.standard.set(true, forKey: "canCall")
        UserDefaults.standard.set(true, forKey: "canEmail")
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {

        if(confirmed) {
            return true
        }
        
        return false
        
    }
    
    @IBAction func confirmClick(_ sender: Any) {
        
        // first attempt
        if (password == "") {
            password = passwordField.text!
            passwordField.text = ""
            passwordField.placeholder = "Please re-enter your password"
            passwordField.becomeFirstResponder()
        }
        // second attempt
        else{
            
            if(password == passwordField.text) {
                
                UserDefaults.standard.set(password, forKey: "userPassword")
                UserDefaults.standard.synchronize()
                
                confirmed = true
                
            } else {
                
                password = ""
                passwordField.text = ""
                passwordField.placeholder = "Your passwords did not match. Please enter your password"
                passwordField.becomeFirstResponder()
                
            }
        }
        
        
    }

}
