//
//  NetworkUtils.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import Foundation
import Combine

final class NetworkUtils {
    /// Fetch Content for given url request
    /// - Parameter request: URLRequest
    /// - Returns: T: Object
    func fetch<T: Codable>(_ request: URLRequest) async throws -> T {
        var request = request
        let apiKey = AppEnvironment.apiKey
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "appid", value: apiKey)
        ]
        request.url?.append(queryItems: queryItems)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.error(error: URLError(.badServerResponse))
        }
        return try requestDecoder(data: data)
    }
}

// MARK: - Encode/Decode Requests

extension NetworkUtils {
    private func requestDecoder<T: Codable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.dateFormat = "YYYY-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch (let error) {
            throw NetworkError.decoding(error: error)
        }
    }
}

// MARK: - HTTP Methods

extension NetworkUtils {
    enum HTTPMethod: String {
        case get = "GET"
    }
}
