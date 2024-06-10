//
//  LandingDataSource.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import Foundation

protocol LandingDataSourceProtocol {
    func getCurrentWeatherData(lat: Double, lon: Double) async throws -> CurrentWeatherDataResponse
}

struct LandingDataSource: LandingDataSourceProtocol {
    func getCurrentWeatherData(lat: Double, lon: Double) async throws -> CurrentWeatherDataResponse {
        guard let route = URLRouter.getCurrentWeatherData(lat: lat, lon: lon).urlComponents?.url else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: route)
        request.httpMethod = NetworkUtils.HTTPMethod.get.rawValue
        // Setting the default cache option to ensure updated weather details are provided.
        
        // TODO: - Cache revalidation is not supported by origin (openweathermap.org)
        /*
        // Allow caching for private caches for 10 minutes, then require revalidation:
        request.addValue("public, max-age=3600, must-revalidate", forHTTPHeaderField:"Cache-Control")
         
        // Use existing cache data if origin can revalidate it.
        request.cachePolicy = .reloadRevalidatingCacheData
        */
        
        let currentWeatherDataResponse: CurrentWeatherDataResponse = try await NetworkUtils().fetch(request)
        return currentWeatherDataResponse
    }
}
