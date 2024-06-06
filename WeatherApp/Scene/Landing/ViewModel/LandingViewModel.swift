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
    var higherLowerTemperature : String { get }
    var isLoading: Bool { get }
    
    func onTapSearchButton()
    func onLoad() async
}
