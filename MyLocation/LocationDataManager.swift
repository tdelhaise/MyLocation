//
//  LocationDataManager.swift
//  MyLocation
//
//  Created by THIERRY DELHAISE on 19/07/2023.
//

import Foundation
import CoreLocation
import OSLog

class LocationDataManager : NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var locationFeaturesEnable = false

    static let logger = Logger(subsystem: "com.delhaise.locationDataManager", category: "location-manager")

    override init() {
        super.init()
        locationManager.delegate = self
        Self.logger.info("LocationDataManager: init")
    }


    // Location-related properties and delegate methods.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Self.logger.info("locationManagerDidChangeAuthorization: ")
        switch manager.authorizationStatus {
            case .authorizedWhenInUse:  // Location services are available.
                enableLocationFeatures()
                break
                
            case .restricted, .denied:  // Location services currently unavailable.
                disableLocationFeatures()
                break
                
            case .notDetermined:        // Authorization not determined yet.
                manager.requestWhenInUseAuthorization()
                break
                
            default:
                break
            }
    }

    func askForPermission() {
        Self.logger.info("askForPermission: called")
        locationManager.requestWhenInUseAuthorization()
    }
    
    func enableLocationFeatures() {
        Self.logger.info("enableLocationFeatures: called")
        self.locationFeaturesEnable = true
    }
    
    func disableLocationFeatures() {
        Self.logger.info("disableLocationFeatures: called")
        self.locationFeaturesEnable = false
        
    }
}
