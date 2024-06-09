//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-08.
//

import CoreLocation
import Combine

protocol LocationManagerProtocol: ObservableObject {
    var location: PassthroughSubject<CLLocation?, Never> { get }
    func requestLocation()
}

class LocationManager: NSObject, LocationManagerProtocol, CLLocationManagerDelegate {
    
    // MARK: - Private
    private var locationManager: CLLocationManager
    private var authorizationStatus: CLAuthorizationStatus = .notDetermined

    // MARK: - Internal
    var location: PassthroughSubject<CLLocation?, Never> = PassthroughSubject()

    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        self.locationManager.startUpdatingLocation()
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        NSLog("Location update in progress")
        self.location.send(latestLocation)
        self.locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
    }
}