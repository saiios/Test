//
//  NetworkServiceProtocol.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//


import Foundation
import Combine

protocol NetworkServiceProtocol {
    func fetchCatFact() -> AnyPublisher<CatFact, Error>
    func fetchCatImage() -> AnyPublisher<[CatImage], Error>
}
import Foundation
import Combine

class NetworkService: NetworkServiceProtocol {

    func fetchCatFact() -> AnyPublisher<CatFact, Error> {
        let urlString = "https://meowfacts.herokuapp.com"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CatFact.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchCatImage() -> AnyPublisher<[CatImage], Error> {
        let urlString = "https://api.thecatapi.com/v1/images/search"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [CatImage].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

