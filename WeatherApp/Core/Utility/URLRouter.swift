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
    let apiType: APIType
    
    init(path: String, queryItems: [URLQueryItem]? = nil, type: APIType) {
        self.path = path
        self.queryItems = queryItems
        self.apiType = type
    }
    
    var urlComponents: URLComponents? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = AppEnvironment.apiURL.absoluteString
        components.path = "/\(apiType.rootPath)/\(apiType.apiVersion)/\(path)"
        components.queryItems = queryItems
        return components
    }
}
