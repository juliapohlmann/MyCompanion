//
//  AddContactViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/7/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import CoreData
import TextFieldEffects
import MobileCoreServices

class ContactDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet var imageView: UIImageView!
    let imagePicker = LandscapeImagePickerController()
    
    var type : String = ""
    var contact : NSManagedObject?
    
    @IBOutlet var nameTextField: JiroTextField!
    @IBOutlet var relationshipTextField: JiroTextField!
    @IBOutlet var numberTextField: JiroTextField!
    @IBOutlet var emailTextField: JiroTextField!
    var imageData: NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStockPhoto()
        
        if(self.type == "Edit Contact") {
            setContactFields()
        }
        self.navigationItem.title = self.type
        
        //set all fields delegate as self
        imagePicker.delegate = self
        nameTextField.delegate = self
        relationshipTextField.delegate = self
        numberTextField.delegate = self
        emailTextField.delegate = self
    }
    
    /**
        If editing an existing contact, set fields with saved values
     
     */
    func setContactFields() {
        nameTextField.text = contact?.value(forKeyPath: "name") as? String
        emailTextField.text = contact?.value(forKeyPath: "email") as? String
        numberTextField.text = contact?.value(forKeyPath: "number") as? String
        relationshipTextField.text = contact?.value(forKeyPath: "relationship") as? String
        if(contact?.value(forKeyPath: "image") != nil) {
            imageView.image = UIImage(data: contact?.value(forKeyPath: "image") as! Data)
            imageData = contact?.value(forKeyPath: "image") as! Data as NSData?
        }
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
        Set stock photo if no photo saved/uploaded
     
     */
    func setStockPhoto() {
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
    }

    /**
        Function that is called when load image button is tapped
     
        - Parameter sender: button that was clicked
     */
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.modalPresentationStyle = .popover
        let presentationController = imagePicker.popoverPresentationController
        presentationController?.sourceView = self.imageView
        
        self.present(imagePicker, animated: true) {}
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            imageData = UIImageJPEGRepresentation(pickedImage, 1) as NSData?
        } else{
            print("Something went wrong")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    /**
        Delegate method for when image picker controll is cancelled
     
        - Parameter picker: picker to dismiss
     */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    /**
        Function that is called when save button is tapped
     
        - Parameter sender: button clicked
     */
    @IBAction func storeContact(_ sender: Any) {
        if(checkInputValidity()) {
            let didSucceed = false
            //if adding contact, use store contact method
            if(type == "Add Contact") {
                didSucceed = ContactDataManager.storeContact(name: nameTextField.text!, relationship: relationshipTextField.text!, number: numberTextField.text, email: emailTextField.text, imageData: imageData)
                
                if(didStore) {
                    performSegue(withIdentifier: "backToEditContacts", sender: self)
                }
            } else {
                //editing contact, update fields of passed contact
                didSucceed = ContactDataManager.updateContact(contact: contact!, name: nameTextField.text!, relationship: relationshipTextField.text!, number: numberTextField.text!, email: emailTextField.text!, imageData: imageData!)
            }
            
            if(didSucceed) {
                performSegue(withIdentifier: "backToEditContacts", sender: self)
            }
        }
    }
    
    /**
        Helper function that checks input values are valid
     
        - Returns: true if valid, false if not
     */
    func checkInputValidity() -> Bool {
        if(nameTextField.text! == "") {
            sendAlert(title: "Missing Name", message: "Please enter a name for the contact")
            return false
        } else if(relationshipTextField.text! == "") {
            sendAlert(title: "Missing Relationship", message: "Please enter a relationship for the contact")
            return false
        } else if((numberTextField.text != "") && !(isValidNumber(value: numberTextField.text!))) {
            sendAlert(title: "Incorrect Phone Number", message: "Please enter a valid phone number (ie. 555-123-4567)")
            return false
        } else if((emailTextField.text != "") && !(isValidEmail(value: emailTextField.text!))) {
            sendAlert(title: "Incorrect Email Address", message: "Please enter a valid email address")
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
    
    /**
        Helper function to determine the validity of a given email
     
        - Parameter value: email to check
     */
    func isValidEmail(value: String) -> Bool {
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: value)
        return result
    }
    
    /**
        Helper function to determine the validity of a given phone number
     
        - Parameter value: number to check
     */
    func isValidNumber(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
}
