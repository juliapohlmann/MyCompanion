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
        
        UserDefaults.standard.set("ipad", forKey: "userPassword")
        UserDefaults.standard.set(true, forKey: "canCall")
        UserDefaults.standard.set(true, forKey: "canEmail")
        UserDefaults.standard.set(true, forKey: "showPhoneNumbers")
        UserDefaults.standard.set(true, forKey: "showEmails")
        UserDefaults.standard.set(true, forKey: "resetRemindersDaily")
        UserDefaults.standard.set(Date(),forKey: "lastOpened")
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
        case 1:
            introText.text = "MyCompanion aims to help individuals with dementia with their day to day activities, from remembering happy time with family to knowing their current location and weather."
        case 2:
            introText.text = "All of the settings and information is set and controller by the caregiver. These controls are in a portal which is password protected and features a quick help section with information fromt the Alzheimer's Assocation."
        case 3:
            introText.text = "Users can view their family and friends and be reminded of their relationship with that individual and a photo. Optionally, caregivers can choose to display the phone number and email and even enable calling and emailing from within MyCompanion."
        case 4:
            introText.text = "A reminders list helps individuals to create and adhere to a daily schedule. Caregivers set the reminders in the caregiver portal and individuals can complete them. Caregivers can also allow reminders to reset daily!"
        case 5:
            introText.text = "Caregivers can also set a memory book. This is a place for caregivers to tell the life story of their ___ through pictures and videos."
        case 6:
            introText.text = "Caregivers have full control on what actions a __ can make while using the app, allowing each caregiver to customize the experience for each individual."
        case 7:
            introText.text = "The caregiver is protected by a password. You'll have to set a password next. "
        case 8:
            askPassword()
        case 9:
            introText.text = "We will also need access to your location to provide information about your location and weather "
        case 10:
            introText.text = "You're all good to go! Click next to enter MyCompanion!"
        case 11:
            toggleAllElements(isHidden: true)
            UserDefaults.standard.set(Date(), forKey: "lastOpened")
            UserDefaults.standard.synchronize()
            self.performSegue(withIdentifier: "toDashboard", sender: self)
        default:
            print("not applicable progress value")
        }
    }
    
    func askPassword() {
        let alertController = UIAlertController(title: "Enter Password", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: {
            alert -> Void in
            let password = alertController.textFields![0].text
            UserDefaults.standard.set(password, forKey: "userPassword")
            UserDefaults.standard.synchronize()
            
            self.progress = 9
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
