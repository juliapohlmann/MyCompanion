//
//  WalkthroughViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 4/23/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import CoreLocation

class WalkthroughViewController: UIViewController, CLLocationManagerDelegate {

    var progress = 0
    
    @IBOutlet var introPic: UIImageView!
    @IBOutlet var introText: UILabel!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var prevLabel: UILabel!
    @IBOutlet var nextLabel: UILabel!
    @IBOutlet var nextIcon: UIImageView!
    @IBOutlet var prevIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextIcon.image = UIImage.fontAwesomeIcon(name: .arrowRight, textColor: UIColor.black, size: CGSize(width: 93, height: 81))
        
        prevIcon.image = UIImage.fontAwesomeIcon(name: .arrowLeft, textColor: UIColor.black, size: CGSize(width: 93, height: 81))
        
        updateView()
        
        
        setTrueIfNull(key: "canCall")
        setTrueIfNull(key: "canEmail")
        setTrueIfNull(key: "showPhoneNumbers")
        setTrueIfNull(key: "showEmails")
        setTrueIfNull(key: "resetRemindersDaily")
        setTrueIfNull(key: "passwordEnabled")
        
        if (UserDefaults.standard.object(forKey: "lastOpened") as? Date) == nil {
            UserDefaults.standard.set(Date(), forKey: "lastOpened")
        }
    
        if (UserDefaults.standard.object(forKey: "userPassword") as? String) == nil {
            UserDefaults.standard.set("", forKey: "userPassword")
        }
        
//        UserDefaults.standard.set(true, forKey: "canCall")
//        UserDefaults.standard.set(true, forKey: "canEmail")
//        UserDefaults.standard.set(true, forKey: "showPhoneNumbers")
//        UserDefaults.standard.set(true, forKey: "showEmails")
//        UserDefaults.standard.set(true, forKey: "resetRemindersDaily")
//        UserDefaults.standard.set(Date(),forKey: "lastOpened")
//        UserDefaults.standard.set(true, forKey: "passwordEnabled")

    }
    
    func setTrueIfNull(key: String) {
        if (UserDefaults.standard.object(forKey: key) as? Bool) == nil {
            UserDefaults.standard.set(true, forKey: key)
        }
    }
    
    @IBAction func clickPrevious(_ sender: Any) {
        
        progress = progress - 1
        updateView()
        
    }
    
    @IBAction func clickNext(_ sender: Any) {
        
        progress = progress + 1
        updateView()
        
    }
    
    func updateView() {
        
        toggleAllElements(isHidden: false)
        
        switch progress {
        case 0:
            hidePreviousElements()
            introText.text = "Welcome to MyCompanion! This application will help you connect with your loved ones as you live each day to its fullest!"
            setPicture(pictureName: "Dashboard")
        case 1:
            introText.text = "All of the settings and information is set and controller by the caregiver. These controls are in a portal which is password protected and features a quick help section with information from the Alzheimer's Assocation."
            if(shouldAskPassword()) {
                introText.text = "\(introText.text!) Now you will be asked to enter a password to access this section."
            }
            setPicture(pictureName: "CaregiverPortal")
        case 2:
            if(shouldAskPassword()) {
                askPassword()
            }
            else {
                clickNext(self)
            }
        case 3:
            introText.text = "Users can view their family and friends and be reminded of their relationship with that individual and a photo."
            setPicture(pictureName: "Contacts")
        case 4:
            introText.text = "A reminders list helps individuals to create and adhere to a daily schedule. Caregivers set the reminders in the caregiver portal and individuals can complete them."
            setPicture(pictureName: "Reminders")
        case 5:
            introText.text = "Caregivers can set up a custom memory book. With 11 different templates and support for text, pictures, and videos, this tool will help everyone reminiscence on family, friends, and good memories."
            setPicture(pictureName: "MemoryBook")
        case 6:
            introText.text = "You are now ready to use MyCompanion! Click next to be taken to the dashboard. Make sure to visit the caregiver portal to customize MyCompanion for you!"
            setPicture(pictureName: "CaregiverPortal")
        case 7:
            UserDefaults.standard.set(Date(), forKey: "lastOpened")
            UserDefaults.standard.synchronize()
            self.performSegue(withIdentifier: "toDashboard", sender: self)
        default:
            print("not applicable progress value")
        }
    }
    
    func shouldAskPassword() -> Bool {
        let storedPassword = UserDefaults.standard.object(forKey: "userPassword") as! String
        return storedPassword.isEmpty
    }
    
    func setPicture(pictureName: String) {
        let fileName = pictureName + "_Walkthrough.png"
        
        introPic!.image = UIImage(named: fileName)
    }
    
    func askPassword() {
        let alertController = UIAlertController(title: "Enter Password", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: {
            alert -> Void in
            let password = alertController.textFields![0].text
            UserDefaults.standard.set(password, forKey: "userPassword")
            UserDefaults.standard.synchronize()
            
            self.progress = 3
            self.updateView()
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Password"
            textField.isSecureTextEntry = true
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func toggleAllElements(isHidden: Bool) {
        self.previousButton.isHidden = isHidden
        self.nextButton.isHidden = isHidden
        self.prevIcon.isHidden = isHidden
        self.nextIcon.isHidden = isHidden
        self.prevLabel.isHidden = isHidden
        self.nextLabel.isHidden = isHidden
    }
    
    func hidePreviousElements() {
        self.previousButton.isHidden = true
        self.prevIcon.isHidden = true
        self.prevLabel.isHidden = true
    }

}
