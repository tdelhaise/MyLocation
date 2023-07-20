//
//  MyLocationApp.swift
//  MyLocation
//
//  Created by THIERRY DELHAISE on 19/07/2023.
//

import SwiftUI
import OSLog

@main
struct MyLocationApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    private static let logger = Logger(subsystem: "com.delhaise.locationApp", category: "app")
    
    private var locationDataManager = LocationDataManager.init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            case .background:
                setupBackgroundState()
            case .active:
                setupActiveState()
            case .inactive:
                setupInactiveState()
            @unknown default:
                setupUnknownState()
            }
        }
    }
    
    func setupBackgroundState() {
        Self.logger.info("setupBackgroundState: called")
    }
    
    func setupActiveState() {
        Self.logger.info("setupActiveState: called")
        switch(self.locationDataManager.locationManager.authorizationStatus) {
        case .authorizedAlways:
            Self.logger.info("status: authorizedAlways")
            Self.logger.info("locationFeatures: \(self.locationDataManager.locationFeaturesEnable)")            
        case .notDetermined:
            Self.logger.info("status: notDetermined")
            Self.logger.info("locationFeatures: \(self.locationDataManager.locationFeaturesEnable)")
            self.locationDataManager.askForPermission()
        case .authorizedWhenInUse:
            Self.logger.info("status: authorizedWhenInUse")
            Self.logger.info("locationFeatures: \(self.locationDataManager.locationFeaturesEnable)")
        case .denied:
            Self.logger.info("status: denied")
            Self.logger.info("locationFeatures: \(self.locationDataManager.locationFeaturesEnable)")
        case .restricted:
            Self.logger.info("status: restricted")
            Self.logger.info("locationFeatures: \(self.locationDataManager.locationFeaturesEnable)")
        @unknown default:
            Self.logger.info("status: unknown default")
        }
    }
    
    func setupInactiveState() {
        Self.logger.info("setupInactiveState: called")
        
    }
    
    func setupUnknownState() {
        Self.logger.info("setupUnknownState: called")
        
    }

}
