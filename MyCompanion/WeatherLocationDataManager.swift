//
//  WeatherLocationDataManager.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/20/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class WeatherLocationDataManager {
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func fetchWeatherLocationData() -> [NSManagedObject] {
        var weatherLocationData : [NSManagedObject] = []
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WeatherLocation")
        
        do {
            weatherLocationData = try context.fetch(fetchRequest)
            return weatherLocationData
        } catch _ as NSError {
            return []
        }
    }
    
    static func storeWeatherLocationData() -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "WeatherLocation", in: context)
        let weatherLocationData = NSManagedObject(entity: entity!, insertInto: context)
        
        weatherLocationData.setValue(0.0, forKey: "latitude")
        weatherLocationData.setValue(0.0, forKey: "longitude")
        weatherLocationData.setValue("", forKey: "city")
        weatherLocationData.setValue("", forKey: "state")
        weatherLocationData.setValue(Date(), forKey: "lastUpdated")
        
        do {
            try context.save()
            return true
            
        } catch _ as NSError {
            return false
        }

    }
    
    static func updateLocationData(weatherLocationData: NSManagedObject, latitude: Double, longitude: Double, city: String, state: String) -> Bool {
        let context = getContext()
        
        weatherLocationData.setValue(latitude, forKey: "latitude")
        weatherLocationData.setValue(longitude, forKey: "longitude")
        weatherLocationData.setValue(city, forKey: "city")
        weatherLocationData.setValue(state, forKey: "state")
        weatherLocationData.setValue(Date(), forKey: "lastUpdated")

        
        do {
            try context.save()
            return true
            
        } catch _ as NSError {
            return false
        }
    }
    
    static func updateWeatherData(weatherLocationData: NSManagedObject, temperature: Int, weatherSummary: String) -> Bool {
        let context = getContext()
        weatherLocationData.setValue(temperature, forKey: "temperature")
        weatherLocationData.setValue(weatherSummary, forKey: "weatherSummary")
        weatherLocationData.setValue(Date(), forKey: "lastUpdated")

        do {
            try context.save()
            return true
            
        } catch _ as NSError {
            return false
        }
    }

    
    

}
