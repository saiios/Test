//
//  ContentViewUITests.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//
import XCTest

final class ContentViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

    // Test if the main view is displayed
    func testMainViewLoads() throws {
        let navigationTitle = app.navigationBars["Tap to Refresh"]
        
        let app = XCUIApplication()
        app.navigationBars["Tap to Refresh"].staticTexts["Tap to Refresh"].tap()
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"A cat has been mayor of Talkeetna, Alaska, for 15 years. His name is Stubbs.").children(matching: .image).element.tap()
        
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.staticTexts["Cats have over 20 muscles that control their ears."].tap()
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Cats bury their feces to cover their trails from predators.").children(matching: .image).element.tap()
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Adult cats only meow to communicate with humans.").children(matching: .image).element.tap()
        elementsQuery.staticTexts["The word 'cat' in various languages: French: chat; German: katze; Italian: gatto; Spanish/Portugese: gato; Yiddish: kats; Maltese: qattus; Swedish/Norwegian: katt; Dutch: kat; Icelandic: kottur; Greek: catta; Hindu: katas; Japanese:neko; Polish: kot; Ukranian: kotuk; Hawiian: popoki; Russian: koshka; Latin: cattus; Egyptian: mau; Turkish: kedi; Armenian: Gatz; Chinese: mao; Arabic: biss; Indonesian: kucing; Bulgarian: kotka; Malay: kucing; Thai/Vietnamese: meo; Romanian: pisica; Lithuanian: katinas; Czech: kocka; Slovak: macka; Armenian: gatz; Basque: catua; Estonian: kass; Finnish: kissa; Swahili: paka."].tap()
        elementsQuery/*@START_MENU_TOKEN@*/.activityIndicators["1"]/*[[".activityIndicators[\"Loading...\"].activityIndicators[\"1\"]",".activityIndicators[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()


        XCTAssertTrue(navigationTitle.exists, "Navigation title 'Tap to Refresh' is not displayed")
    }

    // Test if cat image and cat fact are displayed
    func testCatImageAndFactDisplayed() throws {
        let catImage = app.images["catImage"]
        let catFactText = app.staticTexts["catFact"]

        // Check if cat image exists
        XCTAssertTrue(catImage.exists, "Cat image should be present")

        // Check if cat fact text is visible
        XCTAssertTrue(catFactText.exists, "Cat fact text should be displayed")
    }

    // Test Pull-to-Refresh Interaction
    func testPullToRefresh() throws {
        let scrollView = app.scrollViews.firstMatch
        XCTAssertTrue(scrollView.exists, "ScrollView should be present on the main view")

        scrollView.swipeDown()

        let loadingText = app.staticTexts["Loading..."]
        XCTAssertTrue(loadingText.exists, "Loading indicator should be present after swipe down")
    }

    // Test Tap Gesture Interaction
    func testTapToRefresh() throws {
        let refreshButton = app.buttons["Refresh"]
        XCTAssertTrue(refreshButton.exists, "Refresh button should be available for tapping")

        refreshButton.tap()

        let catFactText = app.staticTexts["catFact"]
        XCTAssertTrue(catFactText.exists, "Cat fact should refresh after tapping")
    }

    // Test Error Handling UI
    func testErrorHandlingUI() throws {
        let errorMessage = app.staticTexts["Error"]

        // Simulate an error
        XCTAssertTrue(errorMessage.exists, "Error message should be present in the UI")
    }
}
