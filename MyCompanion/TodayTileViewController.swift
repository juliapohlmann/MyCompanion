//
//  TodayView.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 1/31/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import Foundation

class TodayTileViewController: UIViewController {
    
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = getTimeText()
        dateLabel.text = dateLabel.text! + " " + getDateText()
    }
    
    func getDateText() -> String {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"

        return dateFormatter.string(from: date as Date)
    }
    
    func getTimeText() -> String{
        let date = NSDate()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date as Date)
        let minutes = calendar.component(.minute, from: date as Date)
        
        return "\(hour):\(minutes)"
    }
}
