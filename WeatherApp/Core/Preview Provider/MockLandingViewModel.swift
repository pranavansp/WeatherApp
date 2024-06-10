//
//  MockLandingViewModel.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import Foundation

class MockLandingViewModel: LandingViewModel {
    var temperatureType: TemperatureType = .celsius
    var temperature: String = "19.0"
    var location: String = "Stockholm"
    var weatherType: String = "Party Cloud"
    var isLoading: Bool = false
    var error: NetworkError? = nil
    var higherTemperature: String = "19"
    var lowTemperature: String = "10"
    var showErrorAlert: Bool = false
    var locationError: LocationManagerError? = nil
    var showLocationErrorAlert: Bool = false
    
    init(error: NetworkError? = nil, showErrorAlert: Bool = false, locationError: LocationManagerError? = nil, showLocationErrorAlert: Bool = false) {
        self.error = error
        self.showErrorAlert = showErrorAlert
        self.locationError = locationError
        self.showLocationErrorAlert = showLocationErrorAlert
    }
    
    func onTapSearchButton() {
        NSLog("mock onTapSearchButton")
    }
    
    func onLoad() {
        NSLog("mock onLoad")
    }
    
    func switchTemperatureType() {
        temperatureType = (temperatureType == .celsius) ? .fahrenheit : .celsius
        NSLog("mock switchTemperatureType")
    }
}
