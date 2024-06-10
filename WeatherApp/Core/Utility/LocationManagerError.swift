//
//  LocationManagerError.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-10.
//

import Foundation

enum LocationManagerError: Error, LocalizedError {
    case accessDenied
    case general
    
    public var errorDescription: String? {
        switch self {
        case .accessDenied:
            return NSLocalizedString("Turn on your location settings in Weather App.", comment: "")
        case .general:
            return NSLocalizedString("Something went wrong, Please try again.", comment: "")
        }
    }
}
