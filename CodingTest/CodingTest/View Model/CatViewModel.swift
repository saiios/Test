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

    func fetchCatData() {
        let factPublisher = networkService.fetchCatFact()
            .map { $0.fact }
            .replaceError(with: "Could not fetch cat fact")

        let imagePublisher = networkService.fetchCatImage()
            .compactMap { $0.first?.url }
            .replaceError(with: "")

        Publishers.Zip(factPublisher, imagePublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] fact, imageUrl in
                self?.catFact = fact
                self?.catImageUrl = imageUrl
            }
            .store(in: &cancellables)
    }
}
