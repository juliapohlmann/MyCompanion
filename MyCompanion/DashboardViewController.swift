//
//  ViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 1/31/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(shouldWalkthrough()) {
            
            DispatchQueue.main.async( execute: {
                self.performSegue(withIdentifier: "segueToWalkthrough", sender: self)
            })
        } else {

            if(shouldResetReminders()) {
                _ = ReminderDataManager.resetAllReminders()
            }
            UserDefaults.standard.set(Date(), forKey: "lastOpened")
            UserDefaults.standard.synchronize()
        }
    }
    
    func shouldWalkthrough() -> Bool{
        if let _ = UserDefaults.standard.object(forKey: "lastOpened") as? Date, let _ = UserDefaults.standard.object(forKey: "userPassword") as? String {
            return false
        } else {
            return true
        }
    }
    
    /**
        Abstracts logic of whether reminders should be reset when dashboard vc is loaded
     
        - Returns: whether reminders should be reset
     */
    func shouldResetReminders() -> Bool {
        let shouldResetDaily = UserDefaults.standard.object(forKey: "resetRemindersDaily") as! Bool
        
        if(shouldResetDaily) {
            
            let lastOpened : Date = UserDefaults.standard.object(forKey: "lastOpened") as! Date
            let currentDate = Date()

            let isSameDay = Calendar.current.isDate(lastOpened, inSameDayAs:currentDate)
            
            if(!isSameDay) {
                return true
            }
        }
        return false
    }
    
    func showMemoryBook() {
        performSegue(withIdentifier: "segueToViewMemoryBook", sender: self)

    }
    
}

