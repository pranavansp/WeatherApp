//
//  DefaultLandingViewModelTests.swift
//  WeatherAppTests
//
//  Created by Pranavan Sivarajah on 2024-06-08.
//

import XCTest
import Combine
@testable import WeatherApp

final class DefaultLandingViewModelTests: XCTestCase {
    
    var defaultLandingViewModel: DefaultLandingViewModel!
    private var cancellable: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        defaultLandingViewModel = nil
        super.tearDown()
    }
    
    func testTemperatureForReceivedResponse() async {
        // Given
        defaultLandingViewModel = DefaultLandingViewModel(dataSource: MockLandingDataSource(), locationManager: MockLocationManager())
        let expectedValues = ["", "15°C"]
        var receivedValues: [String] = []
        let expectation = expectation(description: "Data fetched and decoded successfully")
        
        // When
        defaultLandingViewModel.$temperature
            .sink { [weak self] temperature in
                receivedValues.append(temperature)
                if receivedValues == expectedValues {
                    expectation.fulfill()
                }
                XCTAssertNil(self?.defaultLandingViewModel.error)
            }
            .store(in: &cancellable)
        
        // Then
        defaultLandingViewModel.onLoad()
        
        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertEqual(receivedValues, expectedValues)
    }
    
    func testActionResultOnSearchButtonTap() async {
        // Given
        defaultLandingViewModel = DefaultLandingViewModel(dataSource: MockLandingDataSource(), locationManager: MockLocationManager())
        
        let expectation = expectation(description: "Search view action received successfully")
        
        // When
        defaultLandingViewModel
            .actionPublisher
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        // Then
        defaultLandingViewModel.onTapSearchButton()
        
        await fulfillment(of: [expectation], timeout: 5)
    }
    
    func testTemperatureFirstSwitch() async {
        // Given
        defaultLandingViewModel = DefaultLandingViewModel(dataSource: MockLandingDataSource(), locationManager: MockLocationManager())
        
        let expectedValues = [TemperatureType.celsius, TemperatureType.fahrenheit, TemperatureType.celsius]
        var receivedValues: [TemperatureType] = []
        
        let expectation = expectation(description: "Switched celsius between fahrenheit successfully")
        
        // When
        defaultLandingViewModel
            .$temperatureType
            .sink { type in
                receivedValues.append(type)
                if receivedValues == expectedValues {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)
        
        // Then
        defaultLandingViewModel.switchTemperatureType() // To F
        defaultLandingViewModel.switchTemperatureType() // To C
        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertEqual(receivedValues, expectedValues)
    }
    
    func testNetworkErrorShowsError() async {
        // Given
        var landingDataSource = MockLandingDataSource()
        landingDataSource.hasThrowError = true
        defaultLandingViewModel = DefaultLandingViewModel(dataSource: landingDataSource, locationManager: MockLocationManager())
        
        let expectation = expectation(description: "Incase of network error show the updated error successfully")
        
        defaultLandingViewModel
            .$error
            .dropFirst()
            .sink(receiveValue: { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            })
            .store(in: &cancellable)
        
        // Then
        defaultLandingViewModel.onLoad()
        
        await fulfillment(of: [expectation], timeout: 5)
    }
}
