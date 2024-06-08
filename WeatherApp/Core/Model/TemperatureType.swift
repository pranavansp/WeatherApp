//
//  TemperatureType.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-08.
//

import Foundation
import SwiftUI

enum TemperatureType {
    case celsius
    case fahrenheit
    
    var unitType: UnitTemperature {
        switch self {
        case .celsius:
            return .celsius
        case .fahrenheit:
            return .fahrenheit
        }
    }
    
    var displayText: LocalizedStringKey {
        switch self {
        case .celsius:
            return Localization.Landing.switchToFahrenheit
        case .fahrenheit:
            return Localization.Landing.switchToCelsius
        }
    }
}
