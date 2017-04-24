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
    
    /**
        Gets current context so core data operations can be done
     
        - Returns: current context
     */
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    /**
        Returns weather data from core data
     
        - Returns: array of core data objects
     */
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
    
    /**
        Create empty weather location entry for core data
     
        - Returns: bool of whether save was succesful
     */
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
    
    /**
        Updates location data of weather location data
     
        - Parameters:
            - weatherLocationData: data object to update
            - latitude: data to save
            - longitude: data to save
            - city: data to save
            - state: data to save
        
        - Returns: bool of whether save was succesful
     */
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
    
    /**
        Updates location data of weather location data
     
        - Parameters:
            - weatherLocationData: data object to update
            - temperature: data to save
            - weatherSummary: data to save
     
        - Returns: bool of whether save was succesful
     */
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
