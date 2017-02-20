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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        let password = passwordTextField.text!
        let originalPassword = UserDefaults.standard.object(forKey: "userPassword") as! String
        
        if (password == originalPassword) {
            
            //segue here
            
        }
        else{
            
            // we need something for forgot password
            
            passwordTextField.text = ""
            passwordTextField.placeholder = "Your passwords did not match. Please reenter your password"
            passwordTextField.becomeFirstResponder()
            
        }
        return true
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
