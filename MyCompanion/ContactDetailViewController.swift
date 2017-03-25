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

class ContactDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    var type : String = ""
//    var navTitle : String = ""
    
    
    @IBOutlet var nameTextField: JiroTextField!
    @IBOutlet var relationshipTextField: JiroTextField!
    @IBOutlet var numberTextField: JiroTextField!
    @IBOutlet var emailTextField: JiroTextField!
    var imageData: NSData? = nil
    
    func setType(type: String) {
        self.type = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStockPhoto()
        self.navigationItem.title = self.type
//        navBar.title = "Your Title"

        
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func setStockPhoto() {
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        
        imageView.image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("hereeee")
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            imageData = UIImageJPEGRepresentation(pickedImage, 1) as NSData?
        } else{
            print("Something went wrong")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: Core Data

    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    @IBAction func storeContact(_ sender: Any) {
        var controller : UIAlertController = UIAlertController()
        if(nameTextField.text! == "") {
            controller = UIAlertController(title: "Missing Name", message: "Please enter a name for the contact", preferredStyle: .alert)
        } else if(relationshipTextField.text! == "") {
            controller = UIAlertController(title: "Missing Relationship", message: "Please enter a relationship for the contact", preferredStyle: .alert)
        } else if((numberTextField.text != "") && !(isValidNumber(value: numberTextField.text!))) {
            controller = UIAlertController(title: "Incorrect Phone Number", message: "Please enter a valid phone number (ie. 555-123-4567)", preferredStyle: .alert)
        } else if((emailTextField.text != "") && !(isValidEmail(testStr: emailTextField.text!))) {
            controller = UIAlertController(title: "Incorrect Email Address", message: "Please enter a valid email address", preferredStyle: .alert)
        }
        else {
            if(type == "Add Contact") {
                let didStore = ContactDataManager.storeContact(name: nameTextField.text!, relationship: relationshipTextField.text!, number: numberTextField.text!, email: emailTextField.text!/*, imageData: imageData!*/)
        
                if(didStore) {
                    performSegue(withIdentifier: "backToEditContacts", sender: self)
                } else {
//                  let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
                    //            errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                    //            present(errorDialog, animated: true)
                }
            } else {
                //EDIT CONTACT
                print("attempting to edit contact")
            }
            
//        }
        }
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(ok)
        present(controller, animated: true, completion: nil)
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func isValidNumber(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
}
