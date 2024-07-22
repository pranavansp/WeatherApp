//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-08.
//

import CoreLocation
import Combine

protocol LocationManagerProtocol: ObservableObject {
    var locationPublisher: AnyPublisher<CLLocation, LocationManagerError> { get }
    func requestLocation()
}

class LocationManager: NSObject, LocationManagerProtocol, CLLocationManagerDelegate {
    
    // MARK: - Private
    private let locationManager: CLLocationManager
    private var authorizationStatus: CLAuthorizationStatus = .notDetermined
    private let location: PassthroughSubject<CLLocation, LocationManagerError> = PassthroughSubject()

    // MARK: - Internal
    var locationPublisher: AnyPublisher<CLLocation, LocationManagerError> {
        return location.eraseToAnyPublisher()
    }
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        self.locationManager.startUpdatingLocation()
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        self.checkStatusForAlert()
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
        self.checkStatusForAlert()
    }
    
    func checkStatusForAlert() {
        if (locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted) {
            let error = LocationManagerError.accessDenied
            NSLog("Location error: %@", error.localizedDescription)
            self.location.send(completion: .failure(.accessDenied))
        }
    }
}

