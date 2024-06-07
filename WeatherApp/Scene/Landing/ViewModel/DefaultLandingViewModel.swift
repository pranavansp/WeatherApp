//
//  DefaultLandingViewModel.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import Foundation
import Combine

typealias WeatherTemperature = Measurement<UnitTemperature>

class DefaultLandingViewModel: LandingViewModel {
    
    // MARK: - Internal
    @Published var temperature: String = ""
    @Published var location: String = ""
    @Published var weatherType: String = ""
    @Published var higherTemperature: String = ""
    @Published var lowTemperature: String = ""
    
    @MainActor @Published var isLoading: Bool = true
    @Published var error: NetworkError? = nil
    
    // MARK: Private
    private var cancellable: Set<AnyCancellable> = []
    private let dataSource: LandingDataSourceProtocol
    
    /// Create a computed property for MeasurementFormatter
    private var measurementFormatter: MeasurementFormatter {
        let numFormatter = NumberFormatter()
        numFormatter.maximumFractionDigits = 0
        let measurementFormatter = MeasurementFormatter()
        /// Set the unit options to use the temperature without unit
        measurementFormatter.unitOptions = .temperatureWithoutUnit
        measurementFormatter.numberFormatter = numFormatter
        return measurementFormatter
    }
    
    // MARK: Private subject
    private var temperatureMeasurement: PassthroughSubject<WeatherTemperature, Never> = PassthroughSubject()
    private var highLowTemperatureMeasurement: PassthroughSubject<(WeatherTemperature,WeatherTemperature), Never> = PassthroughSubject()
    
    // MARK: - Init
    init(dataSource: LandingDataSourceProtocol = LandingDataSource()) {
        self.dataSource = dataSource
        self.bind()
    }
    
    // MARK: - Bind
    private func bind() {
        temperatureMeasurement
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                self.temperature = self.measurementFormatter.string(from: value)
            }
            .store(in: &cancellable)
        
        highLowTemperatureMeasurement
            .receive(on: DispatchQueue.main)
            .sink { [weak self] high, low in
                guard let self = self else { return }
                self.higherTemperature = self.measurementFormatter.string(from: high)
                self.lowTemperature = self.measurementFormatter.string(from: low)
            }
            .store(in: &cancellable)
    }
    
    // MARK: - Internal
    func onTapSearchButton() {
        
    }
    
    // MARK: - Load on view appear.
    func onLoad() async {
        Task { [weak self] in
            guard let self = self else { return }
            await MainActor.run {
                self.isLoading = true
            }
            do {
                let dataSourceFetch =  try await dataSource.getCurrentWeatherData(location: "Stockholm")
                // Set temperature values
                self.temperatureMeasurement.send(Measurement(value: dataSourceFetch.main.temp, unit: UnitTemperature.celsius))
                let highTemp = Measurement(value: dataSourceFetch.main.tempMax, unit: UnitTemperature.celsius)
                let lowTemp = Measurement(value: dataSourceFetch.main.tempMin, unit: UnitTemperature.celsius)
                self.highLowTemperatureMeasurement.send((highTemp,lowTemp))
                await MainActor.run {
                    self.location = dataSourceFetch.name
                    self.weatherType = dataSourceFetch.getWeatherType()
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.error = .network(error: error)
                }
            }
        }
    }
}
