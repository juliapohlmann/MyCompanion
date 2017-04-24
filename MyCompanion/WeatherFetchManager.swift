//
//  WeatherFetchManager.swift
//  MyCompanion
//
//  Modeled after example at https://cocoacasts.com/building-a-weather-application-with-swift-3-fetching-weather-data/
//
//  Created by Julia Pohlmann on 4/19/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation


class WeatherFetchManager {
    
    //constants for fetching weather data from DarkSky API
    static let API_KEY = "c3c80470a6c9cf1a1abf7bc5588cc352"
    static let BASE_URL = URL(string:"https://api.darksky.net/forecast/")!
    
    //typealias to help with returning result or error
    typealias WeatherDataCompletion = (AnyObject?, Bool) -> ()
    
    /**
        Starts the call for weather data for the given location inputs
     
        - Parameter latitude: latitude of location
        - Parameter longitude: longitude of location
        - Parameter completion: completion object to return
     */
    static func weatherDataForLocation(latitude: Double, longitude: Double, completion: @escaping WeatherDataCompletion) {
        let URL = BASE_URL.appendingPathComponent(API_KEY).appendingPathComponent("\(latitude),\(longitude)")
        
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            self.didFetchWeatherData(data: data, response: response, error: error, completion: completion)
            }.resume()
    }
    
    /**
        handles response
     
        - Parameter data: returned data
        - Parameter response: url response value
        - Parameter error: returned error
        - Parameter completion: completion object to return
     */
    static private func didFetchWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: WeatherDataCompletion) {
        if (error != nil) {
            completion(nil, true)
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                parseReturnedJSON(data: data, completion: completion)
            } else {
                completion(nil, true)
            }
        }
    }
    
    /**
        Parses JSON response
     
        - Parameter data: data object
        - Parameter completion: completion object to return
     */
    static private func parseReturnedJSON(data: Data, completion: WeatherDataCompletion) {
        if let JSON = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject {
            let currently = JSON["currently"] as? [String: AnyObject]
            let summary = currently?["summary"] as? String
            let temperature = currently?["temperature"] as? Double
            
            let toReturn : AnyObject = [summary!, temperature!] as AnyObject
            
            completion(toReturn, false)
        } else {
            completion(nil, true)
        }
    }
    
}
