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
    
    //api key: c3c80470a6c9cf1a1abf7bc5588cc352
    //https://api.darksky.net/forecast/c3c80470a6c9cf1a1abf7bc5588cc352/37.8267,-122.4233
    
    func getWeather() {
        let apiKey = "c3c80470a6c9cf1a1abf7bc5588cc352"
        let baseURL = URL(string:"https://api.darksky.net/forecast/")!
        let authBaseURL = baseURL.appendingPathComponent(apiKey)
         print("lat: \(lat), long: \(long)")
        let temp = ""
        let summary = ""
        WeatherDataManager.weatherDataForLocation(latitude: lat, longitude: long) { (response, error) in
            print("response: \(response!)")
            
            
//            var data = response!.data(using: String.Encoding.utf8.rawValue)!
//            let json = try? JSONSerialization.jsonObject(with: data)
//            print(json)
            
//            print(json?["currently"])
            
        }
//            do {
//                if let data = response,
//                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
//                    let weatherData = json["response"] as? [[String: Any]] {
//                    let currently = weatherData[0]
//                    temp = currently["apparentTemperature"] as? String
//                    summary = currently["summary"] as? String
//                }
//            } catch {
//                print("Error deserializing JSON: \(error)")
//            }
//        }
    }
    
    
    
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
                    self.locationLabel.text = "You are in \(self.city)."
                    self.lat = location.coordinate.latitude
                    self.long = location.coordinate.longitude
                    
                    print(self.city)
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
