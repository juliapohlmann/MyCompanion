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
        
        setDateText()
        manager.delegate = self
        
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
    
    /**
        Uses existing weather location data values to populate field values
     */
    func useCachedValues() {
        let city = self.currentData!.value(forKeyPath: "city") as! String
        let state = self.currentData!.value(forKeyPath: "state") as! String
        let temperature = self.currentData!.value(forKeyPath: "temperature") as! Int
        let weatherSummary = self.currentData!.value(forKeyPath: "weatherSummary") as! String
        
        setLocationText(city: city, state: state, error: false)
        setWeatherText(city: city, temperature: temperature, weatherSummary: weatherSummary, error: false)
    }
    
    /**
        Creates weather location data object then starts fetching of location/weather
     */
    func initialWeatherFetch() {
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
    
    /**
        Sets weather text field text to values of passed parameter or static message if error fetching
     
        - Parameter city: city to show
        - Parameter temperature: temperature to show
        - Parameter weatherSummary: weather summary to show
        - Parameter error: whether there was an error updating values
     */
    func setWeatherText(city: String?, temperature: Int?, weatherSummary: String?, error: Bool?) {
        if(error!) {
            self.weatherLabel.text = "Fetching your weather now..."
        }
        else {
            self.weatherLabel.text = "In \(city!), it is \(temperature!)° and \(weatherSummary!)."
        }
    }
    
    /**
        Sets location text field text to values of passed parameter or static message if error fetching
     
        - Parameter city: city to show
        - Parameter state: state to show
        - Parameter error: whether there was an error updating values
     */
    func setLocationText(city: String?, state: String?, error: Bool?) {
        if(error!) {
            self.locationLabel.text = "Fetching your location now..."
        }
        else {
            self.locationLabel.text = "You are in \(city!), \(state!)."
        }
    }
    
    /**
        Abstracts logic to determine if weather should be fetched or use cached values
     
        - Returns: true if should be updated
     */
    func shouldUpdateWeatherLocation() -> Bool {
        let currentDate = Date()
        let lastUpdated = currentData!.value(forKeyPath: "lastUpdated") as! Date
        
        let interval = currentDate.timeIntervalSince(lastUpdated)
        
        return (interval > INTERVAL_REFRESH)
    }
    
    /**
        Sets the date text field
     
     */
    func setDateText() {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"

        dateLabel.text = dateFormatter.string(from: date as Date)
    }


    /**
        Fetches weather and updates label value
     */
    func getWeather() {
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
    
    /**
        called if getting location succeeded
     
        - Parameter manager: CLLocationManager
        - Parameter locations: array of locations
     */
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
    
    /**
        called if getting location failed
     
        - Parameter manager: CLLocationManager
        - Parameter error: failure error
     */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        self.setLocationText(city: nil, state: nil, error: true)
    }
}
