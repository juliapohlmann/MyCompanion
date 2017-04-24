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
    let INTERVAL_REFRESH = 900.0
    var currentData : NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = getDateText()
        manager.delegate = self
        
        //NEED TO PUT THIS IN WALKTHROUGH
        manager.requestAlwaysAuthorization()
        //
        
        var weatherLocData = WeatherLocationDataManager.fetchWeatherLocationData()
        if(weatherLocData.count == 0) {
            initialWeatherFetch()
        } else {
            currentData = weatherLocData[0]
            if(shouldUpdateWeatherLocation()) {
                manager.requestLocation()
            } else {
                useCachedValues()
            }
        }
    }
    
    private func useCachedValues() {
        let city = self.currentData!.value(forKeyPath: "city") as! String
        let state = self.currentData!.value(forKeyPath: "state") as! String
        let temperature = self.currentData!.value(forKeyPath: "temperature") as! Int
        let weatherSummary = self.currentData!.value(forKeyPath: "weatherSummary") as! String
        
        setLocationText(city: city, state: state, error: false)
        setWeatherText(city: city, temperature: temperature, weatherSummary: weatherSummary, error: false)
    }
    
    private func initialWeatherFetch() {
        let storeResult = WeatherLocationDataManager.storeWeatherLocationData()
        if(storeResult) {
            let weatherLocData = WeatherLocationDataManager.fetchWeatherLocationData()
            currentData = weatherLocData[0]
            manager.requestLocation()
        } else {
            print("Error creating weather data object")
            setWeatherText(city: nil, temperature: nil, weatherSummary: nil, error: true)
        }
    }
    
    private func setWeatherText(city: String?, temperature: Int?, weatherSummary: String?, error: Bool?) {
        if(error!) {
            self.weatherLabel.text = "Fetching your weather now..."
        }
        else {
            self.weatherLabel.text = "In \(city!), it is \(temperature!)° and \(weatherSummary!)."
        }
    }
    
    private func setLocationText(city: String?, state: String?, error: Bool?) {
        if(error!) {
            self.locationLabel.text = "Fetching your location now..."
        }
        else {
            self.locationLabel.text = "You are in \(city!), \(state!)."
        }
    }
    
    private func shouldUpdateWeatherLocation() -> Bool {
        let currentDate = Date()
        let lastUpdated = currentData!.value(forKeyPath: "lastUpdated") as! Date
        
        let interval = currentDate.timeIntervalSince(lastUpdated)
        
        return (interval > INTERVAL_REFRESH)
    }
    
    private func getDateText() -> String {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"

        return dateFormatter.string(from: date as Date)
    }


    
    private func getWeather() {
        let latitude = currentData!.value(forKeyPath: "latitude") as! Double
        let longitude = currentData!.value(forKeyPath: "longitude") as! Double
        
        WeatherFetchManager.weatherDataForLocation(latitude: latitude, longitude: longitude) { (response, error) in
            if(error) {
                self.setWeatherText(city: nil, temperature: nil, weatherSummary: nil, error: true)
                print("Problem retrieving weather information")
            } else {
                let responseData : NSArray = response! as! NSArray
                let weatherSummary = ((responseData[0] as? String)!).lowercased()
                let temperature = Int((responseData[1] as? Double)!)
                let city = self.currentData!.value(forKeyPath: "city") as! String
                self.setWeatherText(city: city, temperature: temperature, weatherSummary: weatherSummary, error: false)
                
                let updateResult = WeatherLocationDataManager.updateWeatherData(weatherLocationData: self.currentData!, temperature: temperature, weatherSummary: weatherSummary)
                if(!updateResult) {
                    print("Problem saving weather data to core data")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                
                if error != nil {
                    print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                    self.setLocationText(city: nil, state: nil, error: true)
                    return
                }
                
                if (placemarks?.count)! > 0 {
                    let pm = placemarks?[0]
                    
                    let city = (pm?.locality!)!
                    let state = (pm?.administrativeArea!)!
                    self.setLocationText(city: city, state: state, error: false)
                    
                    let latitude = location.coordinate.latitude
                    let longitude = location.coordinate.longitude
                    
                    let updateResult = WeatherLocationDataManager.updateLocationData(weatherLocationData: self.currentData!, latitude: latitude, longitude: longitude, city: city, state: state)
                    
                    if(updateResult) {
                        self.getWeather()
                    } else {
                        print("Problem saving location data to core data")
                    }
                }
                else {
                    print("Problem with the data received from geocoder")
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        self.setLocationText(city: nil, state: nil, error: true)
    }
}
