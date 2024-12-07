//
//  ContentViewUITests.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//

import XCTest

class ContentViewUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        app.terminate()
    }

    // MARK: - Test Launching App and Verifying UI Elements
    func testLaunchAppAndVerifyContent() {
        let catFactLabel = app.staticTexts["Cat Fact"]
        let catImage = app.images["catImageView"]

        // Wait for the content to load
        let exists = NSPredicate(format: "exists == true")

        // Verify the cat fact text appears
        expectation(for: exists, evaluatedWith: catFactLabel, handler: nil)
        expectation(for: exists, evaluatedWith: catImage, handler: nil)

        waitForExpectations(timeout: 10) { _ in
            XCTAssertTrue(catFactLabel.exists)
            XCTAssertTrue(catImage.exists)
        }
    }

    // MARK: - Test Pull-To-Refresh Action
    func testPullToRefresh() {
        let scrollView = app.scrollViews.element

        // Simulate pull-to-refresh by dragging downwards
        let start = scrollView.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.2))
        let end = scrollView.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8))

        start.press(forDuration: 0.1, thenDragTo: end)

        // Ensure the content updates after refreshing
        let refreshedCatFact = app.staticTexts["Cat Fact"]

        expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: refreshedCatFact, handler: nil)

        waitForExpectations(timeout: 5) { _ in
            XCTAssertTrue(refreshedCatFact.exists)
        }
    }

    // MARK: - Test Error Handling UI
    func testDisplayErrorMessage() {
        // Temporarily inject faulty network service
        app.launchArguments += ["SIMULATE_ERROR"]

        app.launch()

        let errorLabel = app.staticTexts["Error: Could not fetch cat fact"]

        expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: errorLabel, handler: nil)

        waitForExpectations(timeout: 5) { _ in
            XCTAssertTrue(errorLabel.exists)
        }
    }
}
