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
            VStack {
                // Details View
                detailView
                // Search location button
                searchLocationButton
            }
            .redacted(reason: viewModel.isLoading ? .placeholder : [])
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .onFirstAppear {
            viewModel.onLoad()
        }
        .disabled(viewModel.isLoading)
        .navigationTitle(Localization.App.title)
        .alert(isPresented: $viewModel.showErrorAlert, error: viewModel.error) {
            Button(Localization.App.ok) {
                viewModel.showErrorAlert.toggle()
            }
        }
    }
    
    // Details View
    var detailView: some View {
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
            Text(Localization.Landing.temperature(viewModel.higherTemperature, viewModel.lowTemperature))
                .fontWeight(.bold)
            temperatureSwitch
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    // Search location button
    var searchLocationButton: some View {
        VStack {
            Button(Localization.Landing.searchTitle, systemImage: SystemImageResource.search.rawValue) {
                self.viewModel.onTapSearchButton()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .frame(alignment: .center)
        .padding(.bottom)
    }
    
    // Temperature switch
    var temperatureSwitch: some View {
        VStack {
            Button(viewModel.temperatureType.displayText) {
                withAnimation {
                    self.viewModel.switchTemperatureType()
                }
            }
            .buttonStyle(.bordered)
            .controlSize(.mini)
            .transition(.opacity)
        }
        .frame(alignment: .center)
        .padding()
    }
}

#Preview {
    NavigationStack {
        LandingView(viewModel: MockLandingViewModel())
    }
}
