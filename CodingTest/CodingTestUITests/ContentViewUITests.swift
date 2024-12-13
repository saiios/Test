//
//  ContentViewUITests.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//
import XCTest

final class ContentViewUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Clean up after each test
        app.terminate()
    }
    
    // MARK: - Helper Method for Waiting
    func waitForElementToAppear(_ element: XCUIElement, timeout: TimeInterval = 10) {
        let exists = element.waitForExistence(timeout: timeout)
        XCTAssertTrue(exists, "Element \(element) did not appear within \(timeout) seconds")
    }
    
    // MARK: - Test Launch State
    
    func testContentViewLaunch() {
        let navigationTitle = app.navigationBars["Tap to Refresh"]
        waitForElementToAppear(navigationTitle)
        
        XCTAssertTrue(navigationTitle.exists, "Navigation bar title should be present on launch")
    }
    
    // MARK: - Test Cat Image Visibility
    
    func testCatImageIsVisible() {
        let catImage = app.images["catImage"]
        waitForElementToAppear(catImage)
        
        XCTAssertTrue(catImage.exists, "Cat image should be present on the view")
    }
    
    // MARK: - Test Cat Fact Text Display
    
    func testCatFactIsDisplayed() {
        let catFactText = app.staticTexts["catFactText"]
        waitForElementToAppear(catFactText)
        
        XCTAssertTrue(catFactText.exists, "Cat fact text should be displayed correctly")
        XCTAssertFalse(catFactText.label.isEmpty, "Cat fact text should not be empty")
    }
}
