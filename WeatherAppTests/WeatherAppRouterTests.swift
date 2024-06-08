//
//  WeatherAppRouterTests.swift
//  WeatherAppTests
//
//  Created by Pranavan Sivarajah on 2024-06-08.
//

import XCTest
import Combine
@testable import WeatherApp

class AssignmentRouterTests: XCTestCase {

    var router: WeatherAppRouter!
    var cancellable: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        router = WeatherAppRouter()
    }

    override func tearDown() {
        router = nil
        super.tearDown()
    }

    func testStartRoot() {
        let expectation = self.expectation(description: "backToHome action should be sent")
        let geocodingUpdateHandler: GeocodingUpdateHandler = { _ in }
        
        router.routingActionSubject
            .sink { action in
                switch action {
                case .searchView(_):
                    expectation.fulfill()
                default:
                    XCTFail("Action should be backToHome")
                }
            }
            .store(in: &cancellable)
        
        router.landingViewActionSubject.send(.onTapSearch(geocodingUpdateHandler))

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testLocationDidSelect() {
        let expectation = self.expectation(description: "Back to home action should be sent")

        router.routingActionSubject
            .sink { action in
                if case .backToHome = action {
                    // Add assertions or further checks related to Geocoding if needed
                    expectation.fulfill()
                } else {
                    XCTFail("Back to home action should be sent")
                }
            }
            .store(in: &cancellable)
        router.searchViewActionSubject.send(.didSelect)

        waitForExpectations(timeout: 1, handler: nil)
    }
}
