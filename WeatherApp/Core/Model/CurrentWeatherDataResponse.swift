//
//  CurrentWeatherDataResponse.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import Foundation

// MARK: - CurrentWeatherDataResponse
struct CurrentWeatherDataResponse: Codable {
    let id: Int
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let name: String
    let cod: Int?
    
    func getWeatherType() -> String {
        return self.weather?.first?.main ?? ""
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon: Double
    let lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let pressure: Int?
    let humidity: Int?
    let tempMin: Double
    let tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case pressure = "pressure"
        case humidity = "humidity"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String?
    let icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
}
