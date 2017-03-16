//
//  CheckPasscodeViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 2/19/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit

class CheckPasscodeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var passwordTextField: UITextField!
    var confirmed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.delegate = self
        passwordTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        
        if(confirmed) {
            return true
        }
        
        return false
        
    }
    
    @IBAction func confirmClick(_ sender: Any) {

        let password = passwordTextField.text!
        let originalPassword = UserDefaults.standard.object(forKey: "userPassword") as! String

        if (password == originalPassword) {
            
            confirmed = true
            
        }
        else{
            
            // we need something for forgot password
            passwordTextField.text = ""
            passwordTextField.placeholder = "Your passwords did not match. Please reenter your password"
            passwordTextField.becomeFirstResponder()
            
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
