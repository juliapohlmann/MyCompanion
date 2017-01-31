//
//  TodayView.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 1/31/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import Foundation

class TodayViewController: UIViewController {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateText = getDateText()
        let timeText = getTimeText()
        dateLabel.text = dateText
        timeLabel.text = timeText
    }
    
    func getDateText() -> String {
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        let fullText : String = String(month) + " " + String(day) + ", " + String(year)
        return fullText
        
    }
    
    func getTimeText() -> String {
        return "5:30"
    }
}
