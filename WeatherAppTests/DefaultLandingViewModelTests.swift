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
        
        let expectation = expectation(description: "Data fetched and decoded successfully")
        
        // When
        defaultLandingViewModel.$temperature
            .dropFirst()
            .sink { [weak self] temperature in
                guard let self else { return }
                XCTAssertEqual(temperature, "15°")
                XCTAssertNil(self.defaultLandingViewModel.error)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        // Then
        defaultLandingViewModel.onLoad()
        
        await fulfillment(of: [expectation], timeout: 5)
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
