//
//  CatFact.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//

import Foundation

struct CatFact: Decodable {
    let data: [String]

    var fact: String {
        data.first ?? "No fact available"
    }
}

struct CatImage: Decodable {
    let url: String
}
