//
//  Category.swift
//  HammerTestApp
//
//  Created by Илья Дубенский on 08.04.2023.
//

import Foundation

enum Category: String, Codable, CaseIterable {
    case all = "all"
    case electronics = "electronics"
    case jewelry = "jewelery"
    case mensClothing = "men's clothing"
    case womensClothing = "women's clothing"
}
