//
//  SearchDataSource.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-07.
//

import Foundation

protocol SearchDataSourceProtocol {
    func getLocation(by keyword: String) async throws -> GeocodingResponse
}

struct SearchDataSource: SearchDataSourceProtocol {
    func getLocation(by keyword: String) async throws -> GeocodingResponse {
        guard let route = URLRouter.getLocation(by: keyword).urlComponents?.url else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: route)
        request.httpMethod = NetworkUtils.HTTPMethod.get.rawValue
        // Use existing cache data in all conditions. Load from the origin only if there is no cache.
        request.cachePolicy = .returnCacheDataElseLoad
        let geocodingResponse: GeocodingResponse = try await NetworkUtils().fetch(request)
        return geocodingResponse
    }
}
