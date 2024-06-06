//
//  URLRouter.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import Foundation

struct URLRouter {
    let path: String
    let queryItems: [URLQueryItem]?
    
    init(path: String, queryItems: [URLQueryItem]? = nil) {
        self.path = path
        self.queryItems = queryItems
    }
    
    var urlComponents: URLComponents? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = AppEnvironment.apiURL.absoluteString
        components.path = "/data/\(AppEnvironment.apiVersion)/\(path)"
        components.queryItems = queryItems
        return components
    }
}
