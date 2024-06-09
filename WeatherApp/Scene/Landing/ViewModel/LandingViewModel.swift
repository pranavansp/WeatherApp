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
    
    var isLoading: Bool { get }
    var error: NetworkError? { get }
    var showErrorAlert: Bool { get set }
    var temperatureType: TemperatureType { get }
        
    func onTapSearchButton()
    func onLoad()
    func switchTemperatureType()
}
