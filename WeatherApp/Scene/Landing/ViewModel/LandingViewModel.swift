//
//  LandingViewModel.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import Foundation

protocol LandingViewModel: ObservableObject {
    var temperature: String { get }
    var location: String { get }
    var weatherType: String { get }
    var higherTemperature : String { get }
    var lowTemperature : String { get }
    var isLoading: Bool { get }
    var error: NetworkError? { get }
    
    func onTapSearchButton()
    func onLoad() async
}
