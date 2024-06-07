//
//  MockSearchViewModel.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-07.
//

import Foundation

class MockSearchViewModel : SearchViewModel {
    var isLoading: Bool = false
    var error: NetworkError? = nil
    var searchKeyword: String = ""
    var resultArray: [Geocoding] = Geocoding.mock
}
