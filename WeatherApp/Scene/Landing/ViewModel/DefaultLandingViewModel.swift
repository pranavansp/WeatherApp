//
//  DefaultLandingViewModel.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import Foundation

class DefaultLandingViewModel: LandingViewModel {
    
    // MARK: - Internal
    @Published var temperature: String = ""
    @Published var location: String = ""
    @Published var weatherType: String = ""
    @Published var higherLowerTemperature: String = ""
    @Published var isLoading: Bool = true
    
    init() {
        
    }
    
    // MARK: - Internal
    func onTapSearchButton() {
        
    }
    
    // MARK: - Load on view appear.
    func onLoad() async {
        
    }
}
