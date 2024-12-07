//
//  NetworkServiceTests.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//


//
//  NetworkServiceTests.swift
//  CodingTestTests
//
//  Created by APPLE on 07/12/24.
//

import XCTest
import Combine
@testable import CodingTest

final class NetworkServiceTests: XCTestCase {

    var networkService: NetworkServiceProtocol!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        networkService = NetworkService()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        networkService = nil
        cancellables = nil
        super.tearDown()
    }

    // MARK: - Test fetchCatFact

    func testFetchCatFactSuccess() {
        let expectation = XCTestExpectation(description: "Fetch Cat Fact Success")

        networkService.fetchCatFact()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed with error: \(error)")
                }
            }, receiveValue: { catFact in
                XCTAssertNotNil(catFact.fact, "Cat fact should not be nil")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5)
    }

    func testFetchCatFactURLInvalid() {
        let expectation = XCTestExpectation(description: "Fetch Cat Fact Invalid URL")

        let invalidService = MockInvalidURLService()

        invalidService.fetchCatFact()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    if let urlError = error as? URLError {
                        XCTAssert(urlError.code == .badURL || urlError.code == .cannotFindHost, "Should fail with bad URL or host not found error")
                        expectation.fulfill()
                    } else {
                        XCTFail("Received unexpected error type")
                    }
                }
            }, receiveValue: { _ in
                XCTFail("Should not receive any value")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5)
    }


    // MARK: - Test fetchCatImage

    func testFetchCatImageSuccess() {
        let expectation = XCTestExpectation(description: "Fetch Cat Image Success")

        networkService.fetchCatImage()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed to fetch cat image with error: \(error)")
                }
            }, receiveValue: { images in
                XCTAssertTrue(images.count > 0, "Should receive at least one cat image")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5)
    }

    func testFetchCatImageURLInvalid() {
        let expectation = XCTestExpectation(description: "Fetch Cat Fact with Invalid URL")

        let invalidService = MockInvalidURLService()

        invalidService.fetchCatFact()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    if let urlError = error as? URLError {
                        // Check if the error is either a bad URL or a host not found error
                        XCTAssert(urlError.code == .badURL || urlError.code == .cannotFindHost, "Should fail with bad URL or host not found error")
                        expectation.fulfill()
                    } else {
                        XCTFail("Received unexpected error type")
                    }
                }
            }, receiveValue: { _ in
                XCTFail("Should not receive any value")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5)
    }

}

// MARK: - MockInvalidURLService

class MockInvalidURLService: NetworkServiceProtocol {
    func fetchCatFact() -> AnyPublisher<CatFact, Error> {
        let invalidURL = "https://invalid-url"
        guard let url = URL(string: invalidURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CatFact.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchCatImage() -> AnyPublisher<[CatImage], Error> {
        let invalidURL = "https://invalid-catapi.com"
        guard let url = URL(string: invalidURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [CatImage].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
