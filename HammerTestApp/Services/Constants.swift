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
    case fakeDataImage = "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"
}

/// Ошибки связанные с сетью
enum NetworkError: String, Error {
    case invalidURL = "Invalid URL"
    case noData = "No Data"
    case decodingError = "Decoding Error"
}

