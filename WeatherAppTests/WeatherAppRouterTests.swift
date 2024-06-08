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
        let expectation = self.expectation(description: "Root action should be sent")

        router.routingActionSubject
            .sink { action in
                switch action {
                case .root:
                    expectation.fulfill()
                default:
                    XCTFail("Action should be root")
                }
            }
            .store(in: &cancellable)

        router.start()

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
        // Force unwrapping: Data from mock
        let geocoding = Geocoding.mock.first!
        router.searchViewActionSubject.send(.didSelect(geocoding))

        waitForExpectations(timeout: 1, handler: nil)
    }
}
