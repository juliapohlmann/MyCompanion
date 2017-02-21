//
//  PasscodeViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 2/19/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit

class PasscodeViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var passwordField: UITextField!
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordField.delegate = self
    }
    
    @IBAction func confirmClick(_ sender: Any) {
        performSegue(withIdentifier: "confirmPasswordToHomeSegue", sender: sender)

    }
    func transition() {
        
        let viewController:ViewController = ViewController()
        //let viewController:CheckPasscodeViewController = CheckPasscodeViewController()
        
        self.present(viewController, animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
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
                
                transition()
                
            } else {
                
                password = ""
                passwordField.text = ""
                passwordField.placeholder = "Your passwords did not match. Please enter your password"
                passwordField.becomeFirstResponder()
                
            }
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
