//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            LandingView(viewModel: MockLandingViewModel())
        }
    }
}
