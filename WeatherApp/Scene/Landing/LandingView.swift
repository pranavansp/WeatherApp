//
//  LandingView.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import SwiftUI

struct LandingView<ViewModel:LandingViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        // Details View
        VStack {
            Text("My Location")
                .font(.title)
            Text(viewModel.location)
                .fontWeight(.bold)
            Text(viewModel.temperature)
                .font(.system(size: 80.0))
            Text(viewModel.weatherType)
                .fontWeight(.bold)
            Text(viewModel.higherLowerTemperature)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        // Search location button
        VStack {
            searchLocation
        }
        .frame(alignment: .center)
        .padding(.bottom)
        .onAppear {
            Task {
                await viewModel.onLoad()
            }
        }
    }
    
    var searchLocation: some View {
        Button("Search for a city or airport", systemImage: "location.magnifyingglass") {
            // Navigation
        }.buttonStyle(.borderedProminent)
    }
}

#Preview {
    NavigationStack {
        LandingView(viewModel: MockLandingViewModel())
    }
}
