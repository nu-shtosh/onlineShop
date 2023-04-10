//
//  ImageManager.swift
//  HammerTestApp
//
//  Created by Илья Дубенский on 04.04.2023.
//

import Foundation

/// Синглтон для работы с изображениями
final class ImageManager {

    static let shared: ImageManager = .init()

    /// Получить изображение
    func fetchImage(from url: URL?,
                    completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = url else {
            completion(.failure(.invalidURL))
            print(NetworkError.invalidURL.rawValue)
            return
        }
        DispatchQueue.global(qos: .utility).async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                print(NetworkError.noData.rawValue)
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
