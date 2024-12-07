//
//  CatViewModelTests.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//

import XCTest
import Combine
@testable import CodingTest

class CatViewModelTests: XCTestCase {

    var viewModel: CatViewModel!
    var networkServiceMock: NetworkServiceMock!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        networkServiceMock = NetworkServiceMock()
        viewModel = CatViewModel(networkService: networkServiceMock)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        networkServiceMock = nil
        cancellables = nil
        super.tearDown()
    }

    // Test fetching a cat fact
    func testFetchCatFact() {
        let expectation = XCTestExpectation(description: "Cat fact fetched successfully")

        // Correctly create CatFact instance
        networkServiceMock.catFactResponse = CatFact(fact: "Cats love napping.")

        viewModel.$catFact
            .dropFirst()
            .sink { fact in
                XCTAssertEqual(fact, "Cats love napping.")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchCatData()

        wait(for: [expectation], timeout: 3)
    }
}
