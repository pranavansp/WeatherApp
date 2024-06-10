//
//  MockLocationManager.swift
//  WeatherAppTests
//
//  Created by Pranavan Sivarajah on 2024-06-08.
//

import Foundation
import Combine
@testable import WeatherApp
import CoreLocation

class MockLocationManager: LocationManagerProtocol {
    var error: PassthroughSubject<WeatherApp.LocationManagerError?, Never> = PassthroughSubject()
    var location: PassthroughSubject<CLLocation?, Never> = PassthroughSubject()
    
    func requestLocation() {
        let mockLocation = CLLocation(latitude: 37.7749, longitude: -122.4194) // San Francisco coordinates
        self.location.send(mockLocation)
    }
}
