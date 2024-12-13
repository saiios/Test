//
//  CatViewModel.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//

import Foundation
import Combine

class CatViewModel: ObservableObject {
    @Published var catFact: String = "Loading cat fact..."
    @Published var catImageUrl: String = ""
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchCatData(completion: @escaping () -> Void) {
        let factPublisher = networkService.fetchCatFact()
        let imagePublisher = networkService.fetchCatImage()

        Publishers.Zip(factPublisher, imagePublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] subscribersCompletion in
                switch subscribersCompletion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
                completion()
            } receiveValue: { [weak self] fact, imageUrl in
                self?.catFact = fact
                self?.catImageUrl = imageUrl
            }
            .store(in: &cancellables)
    }
}


