//
//  Constants.swift
//  HammerTestApp
//
//  Created by Илья Дубенский on 04.04.2023.
//

import Foundation

/// Ссылки
enum Link: String {
    case fakeDataProducts = "https://fakestoreapi.com/products"
}

/// Ошибки связанные с сетью
enum NetworkError: String, Error {
    case invalidURL = "Invalid URL"
    case noData = "No Data"
    case decodingError = "Decoding Error"
}

