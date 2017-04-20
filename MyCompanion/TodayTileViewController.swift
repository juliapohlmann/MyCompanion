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
import CoreData

class TodayTileViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    
    let manager = CLLocationManager()
    
    var currentData : NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = getDateText()
        manager.delegate = self
        
        //NEED TO PUT THIS IN WALKTHROUGH
        manager.requestAlwaysAuthorization()
        
        var weatherLocData = WeatherLocationDataManager.fetchWeatherLocationData()
        if(weatherLocData.count <= 0) {
            WeatherLocationDataManager.storeWeatherLocationData()
            weatherLocData = WeatherLocationDataManager.fetchWeatherLocationData()
            currentData = weatherLocData[0]
            manager.requestLocation()
        } else {
            currentData = weatherLocData[0]
            if(shouldUpdateWeatherLocation()) {
                manager.requestLocation()
            } else {
                let city = self.currentData!.value(forKeyPath: "city") as! String
                let state = self.currentData!.value(forKeyPath: "state") as! String
                let temperature = self.currentData!.value(forKeyPath: "temperature") as! Int
                let weatherSummary = self.currentData!.value(forKeyPath: "weatherSummary") as! String
                setLocationText(city: city, state: state)
                setWeatherText(city: city, temperature: temperature, weatherSummary: weatherSummary)
            }
        }
    }
    
    func setWeatherText(city: String, temperature: Int, weatherSummary: String) {
        
        self.weatherLabel.text = "In \(city), it is \(temperature)° and \(weatherSummary)."
    }
    
    func setLocationText(city: String, state: String) {
        self.locationLabel.text = "You are in \(city), \(state)."
    }
    
    func shouldUpdateWeatherLocation() -> Bool {
        let currentDate = Date()
//        print("CURRENT: \(currentDate)")
        let lastUpdated = currentData!.value(forKeyPath: "lastUpdated") as! Date
//        print("LAST UPDATE LOCATION: \(lastUpdated)")
        
        let interval = currentDate.timeIntervalSince(lastUpdated)
//        print("INTERVAL: \(interval), 15 minutes is 900 seconds")
        print("greater than 15? \(interval > 900)")
        
        return (interval > 900)
    }
    
    func getDateText() -> String {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"

        return dateFormatter.string(from: date as Date)
    }


    
    func getWeather() {
        let latitude = currentData!.value(forKeyPath: "latitude") as! Double
        let longitude = currentData!.value(forKeyPath: "longitude") as! Double
        WeatherDataManager.weatherDataForLocation(latitude: latitude, longitude: longitude) { (response, error) in
            let responseData : NSArray = response! as! NSArray
            let weatherSummary = ((responseData[0] as? String)!).lowercased()
            let temperature = Int((responseData[1] as? Double)!)
            let city = self.currentData!.value(forKeyPath: "city") as! String
            self.setWeatherText(city: city, temperature: temperature, weatherSummary: weatherSummary)
            
            _ = WeatherLocationDataManager.updateWeatherData(weatherLocationData: self.currentData!, temperature: temperature, weatherSummary: weatherSummary)
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
                    
                    let city = (pm?.locality!)!
                    let state = (pm?.administrativeArea!)!
//                    self.locationLabel.text = "You are in \(city), \(state)."
                    self.setLocationText(city: city, state: state)
                    
                    let latitude = location.coordinate.latitude
                    let longitude = location.coordinate.longitude
                    
                    _ = WeatherLocationDataManager.updateLocationData(weatherLocationData: self.currentData!, latitude: latitude, longitude: longitude, city: city, state: state)
                    
                    self.getWeather()
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
