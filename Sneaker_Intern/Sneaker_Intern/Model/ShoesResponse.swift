//
//  ShoesResponse.swift
//  Sneaker_Intern
//
//  Created by Nguyễn Hữu Toàn on 17/10/2022.
//

import Foundation

struct ShoesResponse: Codable {
    let shoes: [ResultItem]
}

struct ResultItem: Codable {
    let id: Int
    let image: URL
    let name: String
    let description: String
    let price: Double
    let color: String
}
