//
//  WeatherDataManager.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/19/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation


class WeatherDataManager {
    static let apiKey = "c3c80470a6c9cf1a1abf7bc5588cc352"
    static let baseURL = URL(string:"https://api.darksky.net/forecast/")!
    
    typealias WeatherDataCompletion = (AnyObject?, Bool) -> ()

//    enum WeatherDataManagerError: Error {
//        
//        case Unknown
//        case FailedRequest
//        case InvalidResponse
//        
//    }

    
    // MARK: - Requesting Data
    static func weatherDataForLocation(latitude: Double, longitude: Double, completion: @escaping WeatherDataCompletion) {
        // Create URL
        let URL = baseURL.appendingPathComponent(apiKey).appendingPathComponent("\(latitude),\(longitude)")
        // Create Data Task
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            self.didFetchWeatherData(data: data, response: response, error: error, completion: completion)
            }.resume()
    }
    
    // MARK: - Helper Methods
    static private func didFetchWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: WeatherDataCompletion) {
        if let _ = error {
            completion(nil, true)
            
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                processWeatherData(data: data, completion: completion)
            } else {
                completion(nil, true)
            }
            
        } else {
            completion(nil, true)
        }
    }
    
    static private func processWeatherData(data: Data, completion: WeatherDataCompletion) {
        if let JSON = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject {
            let currently = JSON["currently"] as? [String: AnyObject]
            let summary = currently?["summary"] as? String
            let temperature = currently?["temperature"] as? Double
            
            let toReturn = [summary!, temperature!] as [Any]
            
            completion(toReturn as AnyObject?, false)
        } else {
            completion(nil, true)
        }
    }
    
}
