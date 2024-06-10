//
//  LandingViewModel.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import Combine

protocol LandingViewModel: ObservableObject {
    var temperature: String { get }
    var location: String { get }
    var weatherType: String { get }
    var higherTemperature : String { get }
    var lowTemperature : String { get }
    var temperatureType: TemperatureType { get }
    
    var isLoading: Bool { get }
    
    // Network
    var error: NetworkError? { get }
    var showErrorAlert: Bool { get set }
    
    // Location
    var locationError: LocationManagerError? { get }
    var showLocationErrorAlert: Bool { get set }
        
    func onTapSearchButton()
    func onLoad()
    func switchTemperatureType()
}
