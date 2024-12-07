//
//  CatFact.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//

import Foundation

struct CatFact: Codable {
    let data: [String]

    var fact: String {
        data.first ?? "No fact available"
    }
}
// Define a model representing the Cat Image
struct CatImage: Codable {
    let url: String

    init(url: String) {
        self.url = url
    }
}
