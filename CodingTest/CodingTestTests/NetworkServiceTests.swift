//
//  NetworkServiceTests.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//

import XCTest
import Combine
@testable import CodingTest

final class NetworkServiceTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()  // Fix: Define cancellables here

    func testFetchCatFact() {
        let service = NetworkService()

        let expectation = XCTestExpectation(description: "Fetch Cat Fact")

        service.fetchCatFact()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed with error: \(error)")
                }
            }, receiveValue: { fact in
                XCTAssertNotNil(fact)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5)
    }
}
