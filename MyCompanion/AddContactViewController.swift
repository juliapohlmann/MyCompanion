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
import ImageIO

class AddContactViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    var contacts: [NSManagedObject] = []
    
    @IBOutlet var nameTextField: JiroTextField!
    @IBOutlet var relationshipTextField: JiroTextField!
    @IBOutlet var numberTextField: JiroTextField!
    @IBOutlet var emailTextField: JiroTextField!
    var imageData: NSData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            imageData = UIImageJPEGRepresentation(pickedImage, 1) as NSData?
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
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)
        let contact = NSManagedObject(entity: entity!, insertInto: context)
        
        contact.setValue(nameTextField.text, forKey: "name")
        contact.setValue(relationshipTextField.text, forKey: "relationship")
        contact.setValue(numberTextField.text, forKey: "number")
        contact.setValue(emailTextField.text, forKey: "email")
        contact.setValue(imageData, forKey: "image")
        
        do {
            try context.save()
            contacts.append(contact)
        } catch let error as NSError {
            let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
            errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(errorDialog, animated: true)
        }
    }
    
}
