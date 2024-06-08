//
//  URLRouter+Weather.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import Foundation

extension URLRouter {
    static func getCurrentWeatherData(lat: Double, lon: Double) -> URLRouter {
        return URLRouter(
            path: "weather",
            queryItems: [
                .init(name: "lat", value: "\(lat)"),
                .init(name: "lon", value: "\(lon)"),
                .init(name: "units", value: "metric")
            ],
            type: .data
        )
    }
}
