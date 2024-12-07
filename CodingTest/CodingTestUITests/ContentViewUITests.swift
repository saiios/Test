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

    // Test Pull-To-Refresh Interaction
    func testPullToRefresh() {
        let scrollView = app.scrollViews.element

        let start = scrollView.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.2))
        let end = scrollView.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8))

        start.press(forDuration: 0.1, thenDragTo: end)

        let refreshedCatFact = app.staticTexts["Cat Fact"]

        expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: refreshedCatFact, handler: nil)

        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Expectation failed with error: \(error)")
            }
        }

        XCTAssertTrue(refreshedCatFact.exists)
    }
}
