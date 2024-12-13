//
//  MockNetworkServiceSuccess.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//

import XCTest
import Combine
@testable import CodingTest

class MockNetworkServiceSuccess: NetworkServiceProtocol {
    func fetchCatFact() -> AnyPublisher<String, Error> {
        let fact = CatFact(data: ["Cats have sharp claws."])
        return Just(fact)
            .map { $0.fact }
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchCatImage() -> AnyPublisher<String, Error> {
        let catImage = CatImage(url: "https://example.com/cat.jpg")
        return Just([catImage])
            .map { $0.first?.url ?? "" }
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class MockNetworkServiceFailure: NetworkServiceProtocol {
    func fetchCatFact() -> AnyPublisher<String, Error> {
        return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }

    func fetchCatImage() -> AnyPublisher<String, Error> {
        return Fail(error: URLError(.cannotFindHost)).eraseToAnyPublisher()
    }
}
