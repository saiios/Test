//
//  NetworkServiceMock.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//

import Foundation
import Combine
@testable import CodingTest

class NetworkServiceMock: NetworkServiceProtocol {

    var catFactResponse: CatFact?
    var catImageResponse: [CatImage]?

    func fetchCatFact() -> AnyPublisher<CatFact, Error> {
        if let response = catFactResponse {
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
    }

    func fetchCatImage() -> AnyPublisher<[CatImage], Error> {
        if let response = catImageResponse {
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
    }
}
