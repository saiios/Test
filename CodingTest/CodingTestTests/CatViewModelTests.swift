//
//  CatModelsTests.swift
//  CodingTestTests
//
//  Created by APPLE on 07/12/24.
//

import XCTest
@testable import CodingTest

final class CatModelsTests: XCTestCase {

    // MARK: - Test CatFact Model
    
    func testCatFactParsing() {
        // Sample JSON response representing the API response
        let jsonData = """
        {
            "data": ["80% of orange cats are male"]
        }
        """.data(using: .utf8)!
        
        do {
            // Decode the data into a CatFact model
            let catFact = try JSONDecoder().decode(CatFact.self, from: jsonData)
            
            // Test if the fact is correctly parsed
            XCTAssertEqual(catFact.fact, "80% of orange cats are male", "The fact should match the provided data")
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
            
            // Since there's no data, the fact should return the default string
            XCTAssertEqual(catFact.fact, "No fact available", "Should handle an empty array gracefully")
        } catch {
            XCTFail("Decoding CatFact failed with error: \(error)")
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
            
            XCTAssertEqual(catImage.url, "https://example.com/cat.jpg", "URL should match the provided data")
        } catch {
            XCTFail("Decoding CatImage failed with error: \(error)")
        }
    }
    
    func testCatImageInitialization() {
        let testURL = "https://sampleurl.com/test.jpg"
        let catImage = CatImage(url: testURL)

        XCTAssertEqual(catImage.url, testURL, "CatImage should correctly initialize with a given URL")
    }
}
