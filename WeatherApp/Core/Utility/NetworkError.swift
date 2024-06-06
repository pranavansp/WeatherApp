//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case network(error: Error)
    case decoding(error: Error)
    case encoding
    case error(error: Error)
    case invalidURL
    
    public var errorDescription: String? {
        switch self {
        case .network(error: let error):
            return NSLocalizedString("Network error: \(error.localizedDescription)", comment: "")
        case .decoding(error: let error):
            return NSLocalizedString("Decoding error: \(error.localizedDescription)", comment: "")
        case .encoding:
            return NSLocalizedString("Encoding error", comment: "")
        case .error(error: let error):
            return NSLocalizedString("Error: \(error.localizedDescription)", comment: "")
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        }
    }
}
