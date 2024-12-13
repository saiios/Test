//
//  CatModelsTests.swift
//  CodingTestTests
//
//  Created by APPLE on 07/12/24.
//

import XCTest
import Combine
@testable import CodingTest

final class CatViewModelTests: XCTestCase {

    var viewModel: CatViewModel!
    var cancellables = Set<AnyCancellable>()

    override func tearDown() {
        viewModel = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchCatDataSuccess() {
        let mockService = MockNetworkServiceSuccess()
        viewModel = CatViewModel(networkService: mockService)

        let expectationFact = XCTestExpectation(description: "Cat Fact Updated")
        let expectationImageUrl = XCTestExpectation(description: "Cat Image URL Updated")

        viewModel.$catFact
            .dropFirst()
            .sink { fact in
                XCTAssertEqual(fact, "Cats have sharp claws.")
                expectationFact.fulfill()
            }
            .store(in: &cancellables)

        viewModel.$catImageUrl
            .dropFirst()
            .sink { imageUrl in
                XCTAssertEqual(imageUrl, "https://example.com/cat.jpg")
                expectationImageUrl.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchCatData {
            expectationFact.fulfill()
            expectationImageUrl.fulfill()
        }

        wait(for: [expectationFact, expectationImageUrl], timeout: 5)
    }

    func testFetchCatDataFailure() {
        let mockService = MockNetworkServiceFailure()
        viewModel = CatViewModel(networkService: mockService)

        let factFailureExpectation = XCTestExpectation(description: "Cat Fact Should Fail")
        let imageFailureExpectation = XCTestExpectation(description: "Cat Image Should Fail")

        viewModel.$catFact
            .dropFirst()
            .sink { fact in
                XCTAssertEqual(fact, "Could not fetch cat fact")
                factFailureExpectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.$catImageUrl
            .dropFirst()
            .sink { imageUrl in
                XCTAssertEqual(imageUrl, "")
                imageFailureExpectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchCatData {
            factFailureExpectation.fulfill()
            imageFailureExpectation.fulfill()
        }

        wait(for: [factFailureExpectation, imageFailureExpectation], timeout: 5)
    }
}
