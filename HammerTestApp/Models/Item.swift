//
//  Item.swift
//  HammerTestApp
//
//  Created by Илья Дубенский on 04.04.2023.
//

import Foundation

struct Item: Decodable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: URL
    let rating: Rating
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}
