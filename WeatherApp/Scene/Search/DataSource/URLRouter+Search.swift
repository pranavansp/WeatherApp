//
//  URLRouter+Search.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-07.
//

import Foundation

extension URLRouter {
    static func getLocation(by keyword: String) -> URLRouter {
        return URLRouter(
            path: "direct",
            queryItems: [
                .init(name: "q", value: "\(keyword)"),
                .init(name: "limit", value: "5")
            ],
            type: .geo
        )
    }
}
