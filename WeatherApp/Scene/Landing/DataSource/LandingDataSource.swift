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
        let currentWeatherDataResponse: CurrentWeatherDataResponse = try await NetworkUtils().fetch(request)
        return currentWeatherDataResponse
    }
}
