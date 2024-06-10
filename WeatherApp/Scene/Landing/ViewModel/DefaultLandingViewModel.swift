//
//  DefaultLandingViewModel.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import Foundation
import Combine

typealias WeatherTemperature = Measurement<UnitTemperature>

final class DefaultLandingViewModel: LandingViewModel {
    
    // MARK: - Actions
    enum LandingViewModelAction {
        case onTapSearch(GeocodingUpdateHandler)
    }
    
    // MARK: - Internal
    @Published var temperature: String = ""
    @Published var location: String = ""
    @Published var weatherType: String = ""
    @Published var higherTemperature: String = ""
    @Published var lowTemperature: String = ""
    @Published var temperatureType: TemperatureType = .celsius
   
    @Published var isLoading: Bool = true
    
    /// Network
    @Published var error: NetworkError? = nil
    @Published var showErrorAlert: Bool = false
    
    /// Location based
    @Published var locationError: LocationManagerError? = nil
    @Published var showLocationErrorAlert: Bool = false
    
    // MARK: Private
    private var cancellable: Set<AnyCancellable> = []
    private let dataSource: LandingDataSourceProtocol
    private var locationManager: any LocationManagerProtocol
    
    /// Create a computed property for MeasurementFormatter
    private var measurementFormatter: MeasurementFormatter {
        let numFormatter = NumberFormatter()
        numFormatter.maximumFractionDigits = 0
        let measurementFormatter = MeasurementFormatter()
        // TODO: - Set the unit options to use the temperature without unit
        measurementFormatter.unitOptions = .providedUnit
        measurementFormatter.numberFormatter = numFormatter
        return measurementFormatter
    }
    
    //MARK: Private (set)
    private (set) var actionPublisher: PassthroughSubject<LandingViewModelAction, Never> = PassthroughSubject()
    
    // MARK: Private subject
    private var temperatureMeasurement: PassthroughSubject<WeatherTemperature, Never> = PassthroughSubject()
    private var highLowTemperatureMeasurement: PassthroughSubject<(WeatherTemperature,WeatherTemperature), Never> = PassthroughSubject()
    private var locationSubject: PassthroughSubject<(Double, Double), Never> = PassthroughSubject()
    
    // MARK: - Init
    init(dataSource: LandingDataSourceProtocol, locationManager: any LocationManagerProtocol = LocationManager()) {
        self.dataSource = dataSource
        self.locationManager = locationManager
        self.bind()
    }
    
    // MARK: - Bind
    private func bind() {
        temperatureMeasurement
            .combineLatest($temperatureType)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value, type in
                guard let self = self else { return }
                var temperatureMeasurement = value
                temperatureMeasurement = temperatureMeasurement.converted(to: type.unitType)
                self.temperature = self.measurementFormatter.string(from: temperatureMeasurement)
            }
            .store(in: &cancellable)
        
        highLowTemperatureMeasurement
            .combineLatest($temperatureType)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] temperatures, type in
                guard let self = self else { return }
                // High
                var highTemperatureMeasurement = temperatures.0
                highTemperatureMeasurement = highTemperatureMeasurement.converted(to: type.unitType)
                // Low
                var lowTemperatureMeasurement = temperatures.1
                lowTemperatureMeasurement = lowTemperatureMeasurement.converted(to: type.unitType)
                
                self.higherTemperature = self.measurementFormatter.string(from: highTemperatureMeasurement)
                self.lowTemperature = self.measurementFormatter.string(from: lowTemperatureMeasurement)
            }
            .store(in: &cancellable)
        
        locationSubject
            .sink { [weak self] lat, lon in
                guard let self = self else { return }
                self.startFetch(lat: lat, lon: lon)
            }
            .store(in: &cancellable)
        
        locationManager
            .location
            .removeDuplicates()
            .compactMap { $0 }
            .map { (Double($0.coordinate.latitude),Double($0.coordinate.longitude)) }
            .sink { [weak self] lat, long in
                guard let self = self else { return }
                self.locationSubject.send((lat,long))
            }
            .store(in: &cancellable)
        
        locationManager
            .error
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.showLocationErrorAlert = true
                self.locationError = error
                self.isLoading = false
            }
            .store(in: &cancellable)
    }
    
    // MARK: - Internal
    func onTapSearchButton() {
        let action = LandingViewModelAction.onTapSearch { [weak self] location in
            guard let self = self else { return }
            guard let lat = location.lat, let lon = location.lon else { return }
            self.locationSubject.send((lat,lon))
        }
        self.actionPublisher.send(action)
    }
    
    // Load on view appear.
    func onLoad() {
        locationManager.requestLocation()
    }
    
    // MARK: - Fetch weather data from network
    
    // To prevent memory leaks, add the Task outside the sink.
    // Using a separate method for starting the fetch helps avoid memory leaks.
    private func startFetch(lat: Double, lon: Double) {
        Task { [weak self] in
            guard let self = self else { return }
            await self.startFetch(lat: lat, lon: lon)
        }
    }
    
    private func startFetch(lat: Double, lon: Double) async {
        Task { [weak self] in
            guard let self = self else { return }
            await MainActor.run {
                self.isLoading = true
            }
            do {
                let dataSourceFetch = try await dataSource.getCurrentWeatherData(lat: lat, lon: lon)
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
                NSLog("Error: %@", error.localizedDescription)
                await MainActor.run {
                    self.isLoading = false
                    self.error = .network(error: error)
                    self.showErrorAlert = true
                }
            }
        }
    }
    
    /// Switch temperature type
    func switchTemperatureType(){
        temperatureType = (temperatureType == .celsius) ? .fahrenheit : .celsius
    }
}
