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
    
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    
    let manager = CLLocationManager()
    var city = ""
    var state = ""
    var lat: Double = 0
    var long: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = getDateText()
        manager.delegate = self
        
        //NEED TO PUT THIS IN WALKTHROUGH
        manager.requestAlwaysAuthorization()
        
        manager.requestLocation()
    }
    
    func getDateText() -> String {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"

        return dateFormatter.string(from: date as Date)
    }
    

    
    func getWeather() {
        var temp = 0.0
        var summary = ""
        var responseData : AnyObject = self
        WeatherDataManager.weatherDataForLocation(latitude: lat, longitude: long) { (response, error) in
            responseData = response!
            summary = (responseData[0] as? String)!
            temp = (responseData[1] as? Double)!

            self.weatherLabel.text = "In \(self.city), it is \(round(temp))° and \(summary.lowercased())."
        }
    }
    

    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                
                if error != nil {
                    print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                    return
                }
                
                if (placemarks?.count)! > 0 {
                    let pm = placemarks?[0]
                    self.city = (pm?.locality!)!
                    self.state = (pm?.administrativeArea!)!
                    self.locationLabel.text = "You are in \(self.city), \(self.state)."
                    self.lat = location.coordinate.latitude
                    self.long = location.coordinate.longitude
                    
//                    self.getWeather()
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
