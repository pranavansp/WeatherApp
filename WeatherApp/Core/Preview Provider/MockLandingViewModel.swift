//
//  MockLandingViewModel.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import Foundation

class MockLandingViewModel: LandingViewModel {
    
    var temperature: String = "19.0"
    var location: String = "Stockholm"
    var weatherType: String = "Party Cloud"
    var higherLowerTemperature: String = "L: 18, H: 19"
    var isLoading: Bool = false
    
    func onTapSearchButton() {
        NSLog("mock onTapSearchButton")
    }
    
    func onLoad() async {
        NSLog("mock onLoad")
    }
}
