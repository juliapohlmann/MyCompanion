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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        self.previousButton.isHidden = false
        self.nextButton.isHidden = false
        self.prevIcon.isHidden = false
        self.nextIcon.isHidden = false
        self.prevLabel.isHidden = false
        self.nextLabel.isHidden = false
        
        if(progress == 0) {
            
            self.previousButton.isHidden = true
            self.prevIcon.isHidden = true
            self.prevLabel.isHidden = true
            
        }
        
        if(progress == 12) {
            
            self.nextButton.isHidden = true
            self.nextIcon.isHidden = true
            self.nextLabel.isHidden = true
            self.previousButton.isHidden = true
            self.prevIcon.isHidden = true
            self.prevLabel.isHidden = true
            self.introPic.isHidden = true
            self.introText.isHidden = true
            
        }
        
        if(progress == 0) {
            
            introText.text = "Welcome to MyCompanion! This app provides a ton of tools to help caregivers!"
            
            
        } else if(progress == 1) {
            
            introText.text = "MyCompanion is a hub for dementia ____ - where they can find information about where they are, their life, their friends, and their schedule."
            
        } else if(progress == 2) {
            
            introText.text = "This information is set by the caregiver, who has their own portal where they have full control of information accessed by the ____"
            
        } else if(progress == 3) {
            
            introText.text = "Caregivers control their list of contacts, and whether they're allowed to call and email them."
            
        } else if(progress == 4) {
            
            introText.text = "Caregivers can also set reminders, which reset daily."
            
        }else if(progress == 5) {
            
            introText.text = "Caregivers can also set a memory book. This is a place for caregivers to tell the life story of their ___ through pictures and videos."
            
        }else if(progress == 6) {
            
            introText.text = "Caregivers have full control on what actions a __ can make while using the app, allowing each caregiver to customize the experience for each individual."
            
        }else if(progress == 7) {
            
            introText.text = "The caregiver is protected by a password. You'll have to set a password next. "
            
        }else if(progress == 8){
            
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
            
        } else if(progress == 9) {
            
            introText.text = "We will also need access to your location to provide information about your location and weather "
            
        } else if(progress == 10) {
            
            let manager = CLLocationManager()
            manager.delegate = self
            manager.requestAlwaysAuthorization()
            
        } else if(progress == 11) {
            
            introText.text = "You're all good to go! Click next to enter MyCompanion!"

        } else if(progress == 12) {
            UserDefaults.standard.set(Date(), forKey: "lastOpened")
            UserDefaults.standard.synchronize()
            self.performSegue(withIdentifier: "toDashboard", sender: self)
            
        }
        
        
        
    }

}
