//
//  CurrentWeatherDataResponse.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import Foundation

// MARK: - CurrentWeatherDataResponse
struct CurrentWeatherDataResponse: Codable {
    var id: Int
    var coord: Coord?
    var weather: [Weather]?
    var base: String?
    var main: Main
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dt: Int?
    var sys: Sys?
    var timezone: Int?
    var name: String
    var cod: Int?
    
    func getWeatherType() -> String {
        return self.weather?.first?.main ?? ""
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    var all: Int?
}

// MARK: - Coord
public struct Coord: Codable {
    var lon: Double
    var lat: Double
}

// MARK: - Main
struct Main: Codable {
    var temp: Double
    var pressure: Int?
    var humidity: Int?
    var tempMin: Double
    var tempMax: Double

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
    var type: Int?
    var id: Int?
    var message: Double?
    var country: String?
    var sunrise: Int?
    var sunset: Int?
}

// MARK: - Weather
struct Weather: Codable {
    var id: Int
    var main: String
    var description: String?
    var icon: String
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double?
    var deg: Int?
}
