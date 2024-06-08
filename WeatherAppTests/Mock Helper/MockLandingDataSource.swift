//
//  MockLandingDataSource.swift
//  WeatherAppTests
//
//  Created by Pranavan Sivarajah on 2024-06-08.
//

@testable import WeatherApp
import Foundation

// MARK: - Mock Data Source
struct MockLandingDataSource: LandingDataSourceProtocol {
    
    var hasThrowError: Bool = false
    
    private let jsonString = """
{
  "coord": {
    "lon": -122.4064,
    "lat": 37.7858
  },
  "weather": [
    {
      "id": 803,
      "main": "Clouds",
      "description": "broken clouds",
      "icon": "04d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 15.04,
    "feels_like": 14.9,
    "temp_min": 11.53,
    "temp_max": 23.59,
    "pressure": 1012,
    "humidity": 88
  },
  "visibility": 10000,
  "wind": {
    "speed": 5.66,
    "deg": 310
  },
  "clouds": {
    "all": 75
  },
  "dt": 1717868043,
  "sys": {
    "type": 2,
    "id": 2007646,
    "country": "US",
    "sunrise": 1717850854,
    "sunset": 1717903818
  },
  "timezone": -25200,
  "id": 5391959,
  "name": "San Francisco",
  "cod": 200
}
"""
    
    func getCurrentWeatherData(lat: Double, lon: Double) async throws -> CurrentWeatherDataResponse {
        guard !hasThrowError else { throw NetworkError.network(error: NSError(domain: "NetworkError Error", code: 0)) }
        let jsonData = jsonString.data(using: .utf8)!
        return try JSONDecoder().decode(CurrentWeatherDataResponse.self, from: jsonData)
    }
}
