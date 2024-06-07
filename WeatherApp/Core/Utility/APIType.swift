//
//  APIType.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-07.
//

enum APIType {
    case geo
    case data
    
    var apiVersion: String {
        switch self {
        case .geo:
            return "1.0"
        case .data:
            return AppEnvironment.apiVersion
        }
    }
    
    var rootPath: String {
        switch self {
        case .geo:
            return "geo"
        case .data:
            return "data"
        }
    }
}
