//
//  NetworkServiceProtocol.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//


import Foundation
import Combine

protocol NetworkServiceProtocol {
    func fetchCatFact() -> AnyPublisher<String, Error>
    func fetchCatImage() -> AnyPublisher<String, Error>
}

class NetworkService: NetworkServiceProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchCatFact() -> AnyPublisher<String, Error> {
        let urlString = "https://meowfacts.herokuapp.com"
        return performRequest(urlString: urlString)
            .map { (response: CatFact) in response.fact }
            .eraseToAnyPublisher()
    }

    func fetchCatImage() -> AnyPublisher<String, Error> {
        let urlString = "https://api.thecatapi.com/v1/images/search"
        return performRequest(urlString: urlString)
            .compactMap { (response: [CatImage]) in response.first?.url }
            .eraseToAnyPublisher()
    }

    private func performRequest<T: Decodable>(urlString: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }
}
