//
//  GeocodingResponse.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-07.
//

import Foundation

typealias GeocodingResponse = [Geocoding]

struct Geocoding: Identifiable, Codable {
    let id: UUID = UUID()
    let name: String?
    let localNames: [String: String]?
    let lat: Double?
    let lon: Double?
    let country: String?
    let state: String?
    
    enum CodingKeys: CodingKey {
        case name
        case localNames
        case lat
        case lon
        case country
        case state
    }
    
    init(name: String, localNames: [String : String]?, lat: Double?, lon: Double?, country: String, state: String) {
        self.name = name
        self.localNames = localNames
        self.lat = lat
        self.lon = lon
        self.country = country
        self.state = state
    }
    
    init(name: String) {
        self.init(name: name, localNames: nil, lat: nil, lon: nil, country: "Country", state: "State")
    }
    
    // Create a label because the API response sometimes does not provide the country and state information.
    func getLabel() -> String {
        let labelArray: [String?] = [name, state, country]
        return labelArray.compactMap { $0 }.joined(separator: ", ")
    }
}

// MARK: - Mock
extension Geocoding {
    static let mock = [
        Geocoding(name: "Stockholm"),
        Geocoding(name: "Malmo"),
        Geocoding(name: "Gullmarsplan")
    ]
}
