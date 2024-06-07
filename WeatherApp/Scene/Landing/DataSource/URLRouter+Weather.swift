//
//  URLRouter+Weather.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import Foundation

extension URLRouter {
    static func getCurrentWeatherData(location: String) -> URLRouter {
        return URLRouter(
            path: "weather",
            queryItems: [
                .init(name: "q", value: "\(location)"),
                .init(name: "units", value: "metric")
            ],
            type: .data
        )
    }
}
