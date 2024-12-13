//
//  CatModelsTests.swift
//  CodingTestTests
//
//  Created by APPLE on 13/12/24.
//

import XCTest
@testable import CodingTest

final class CatModelsTests: XCTestCase {

    // MARK: - Test CatFact Model
    
    func testCatFactParsing() {
        let jsonData = """
        {
            "data": ["Cats are very agile animals."]
        }
        """.data(using: .utf8)!
        
        do {
            let catFact = try JSONDecoder().decode(CatFact.self, from: jsonData)
            XCTAssertEqual(catFact.fact, "Cats are very agile animals.")
        } catch {
            XCTFail("Decoding CatFact failed with error: \(error)")
        }
    }
    
    func testCatFactEmptyData() {
        let jsonData = """
        {
            "data": []
        }
        """.data(using: .utf8)!
        
        do {
            let catFact = try JSONDecoder().decode(CatFact.self, from: jsonData)
            XCTAssertEqual(catFact.fact, "No fact available")
        } catch {
            XCTFail("Decoding CatFact with empty data failed: \(error)")
        }
    }

    // MARK: - Test CatImage Model
    
    func testCatImageParsing() {
        let jsonData = """
        {
            "url": "https://example.com/cat.jpg"
        }
        """.data(using: .utf8)!
        
        do {
            let catImage = try JSONDecoder().decode(CatImage.self, from: jsonData)
            XCTAssertEqual(catImage.url, "https://example.com/cat.jpg")
        } catch {
            XCTFail("Decoding CatImage failed with error: \(error)")
        }
    }
    
    func testCatImageInitialization() {
        let testURL = "https://sample.com/test.jpg"
        let catImage = CatImage(url: testURL)
        XCTAssertEqual(catImage.url, testURL)
    }
}
