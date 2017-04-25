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
        
        if(shouldResetReminders()) {
            _ = ReminderDataManager.resetAllReminders()
        }
        
        UserDefaults.standard.set(Date(), forKey: "lastOpened")
        UserDefaults.standard.synchronize()
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
    
}

