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
        ZStack {
            if viewModel.isLoading {
                ProgressView(Localization.App.loadingTitle)
                    .controlSize(.large)
                    .font(.headline)
            } else {
                VStack {
                    // Details View
                    detailView
                    // Search location button
                    searchLocationButton
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.onLoad()
            }
        }
    }
    
    // Details View
    private var detailView: some View {
        VStack {
            Text(Localization.Landing.title)
                .font(.title)
            Text(viewModel.location)
                .fontWeight(.bold)
                .textCase(.uppercase)
            Text(viewModel.temperature)
                .font(.system(size: 80.0))
            Text(viewModel.weatherType)
                .fontWeight(.bold)
            Text(Localization.Landing.temperature(viewModel.higherTemperature,viewModel.lowTemperature))
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    // Search location button
    private var searchLocationButton: some View {
        VStack {
            Button(Localization.Landing.searchTitle, systemImage: SystemImageResource.search.rawValue) {
                // Navigation
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .frame(alignment: .center)
        .padding(.bottom)
    }
}

#Preview {
    NavigationStack {
        LandingView(viewModel: MockLandingViewModel())
    }
}