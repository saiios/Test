//
//  MockNetworkServiceSuccess.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//

import XCTest
import Combine
@testable import CodingTest

// Mock NetworkService to simulate different responses
class MockNetworkServiceSuccess: NetworkServiceProtocol {
    func fetchCatFact() -> AnyPublisher<CatFact, Error> {
        let fact = CatFact(data: ["Cats have sharp claws."])
        return Just(fact)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchCatImage() -> AnyPublisher<[CatImage], Error> {
        let image = [CatImage(url: "https://example.com/cat.jpg")]
        return Just(image)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class MockNetworkServiceFailure: NetworkServiceProtocol {
    func fetchCatFact() -> AnyPublisher<CatFact, Error> {
        return Fail(error: URLError(.badURL))
            .eraseToAnyPublisher()
    }

    func fetchCatImage() -> AnyPublisher<[CatImage], Error> {
        return Fail(error: URLError(.cannotFindHost))
            .eraseToAnyPublisher()
    }
}

class CatViewModelTests: XCTestCase {

    var viewModel: CatViewModel!
    var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        viewModel = nil
        cancellables.removeAll()
        super.tearDown()
    }

    // Test successful fetching of cat fact and image
    func testFetchCatDataSuccess() {
        let mockService = MockNetworkServiceSuccess()
        viewModel = CatViewModel(networkService: mockService)

        let expectationFact = XCTestExpectation(description: "Cat Fact Updated")
        let expectationImageUrl = XCTestExpectation(description: "Cat Image URL Updated")

        viewModel.$catFact
            .dropFirst()  // Avoid initial default value
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

        viewModel.fetchCatData()

        wait(for: [expectationFact, expectationImageUrl], timeout: 5)
    }

    // Test failed fetching of cat fact and image
    func testFetchCatDataFailure() {
        let mockService = MockNetworkServiceFailure()
        viewModel = CatViewModel(networkService: mockService)

        let expectationFactFailure = XCTestExpectation(description: "Cat Fact Should Fail")
        let expectationImageFailure = XCTestExpectation(description: "Cat Image Should Fail")

        viewModel.$catFact
            .dropFirst()
            .sink { fact in
                XCTAssertEqual(fact, "Could not fetch cat fact")
                expectationFactFailure.fulfill()
            }
            .store(in: &cancellables)

        viewModel.$catImageUrl
            .dropFirst()
            .sink { imageUrl in
                XCTAssertEqual(imageUrl, "")
                expectationImageFailure.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchCatData()

        wait(for: [expectationFactFailure, expectationImageFailure], timeout: 5)
    }
}
