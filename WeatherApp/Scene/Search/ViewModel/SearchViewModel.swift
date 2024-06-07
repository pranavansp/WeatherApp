//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-07.
//

import Foundation

protocol SearchViewModel: ObservableObject {
    var searchKeyword: String { set get }
    var resultArray: [Geocoding] { get }
    var isLoading: Bool { get }
    var error: NetworkError? { get }
}
