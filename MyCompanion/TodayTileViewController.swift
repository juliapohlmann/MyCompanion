//
//  TodayView.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 1/31/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class TodayTileViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    let manager = CLLocationManager()
    var city = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(getDateText())
        
        manager.delegate = self
        
        //NEED TO PUT THIS IN WALKTHROUGH
        manager.requestAlwaysAuthorization()
        
        manager.requestLocation()
        
        //timeLabel.text = getTimeText()
        //dateLabel.text = dateLabel.text! + " " + getDateText()
    }
    
    func getDateText() -> String {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"

        return dateFormatter.string(from: date as Date)
    }
    
//    func getTimeText() -> String{
//        let date = NSDate()
//        let calendar = Calendar.current
//        var hour = calendar.component(.hour, from: date as Date)
//        if(hour > 12) {
//            hour = hour - 12
//        }
//        let minutes = calendar.component(.minute, from: date as Date)
//        
//        return "\(hour):\(minutes)"
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                print(location)
                
                if error != nil {
                    print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                    return
                }
                
                if (placemarks?.count)! > 0 {
                    let pm = placemarks?[0]
                    self.city = (pm?.locality!)!
                    print(self.city)
                }
                else {
                    print("Problem with the data received from geocoder")
                }
            })

        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
