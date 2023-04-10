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
    
    func fetchImageData(from url: URL?) -> Data? {
        guard let url = url else {
            print(NetworkError.invalidURL.rawValue)
            return nil
        }
        guard let imageData = try? Data(contentsOf: url) else {
            print(NetworkError.noData.rawValue)
            return nil
        }
        return imageData
    }

    func fetchWithURLSession(from url: URL?) -> Data? {
        var data: Data?
        guard let url = url else {
            print(NetworkError.invalidURL.rawValue)
            return nil
        }
        URLSession(configuration: .default).dataTask(with: url) { (imageData, response, error) in
            if let error {
                print("Error downloading cat picture: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("Response code \(response.statusCode)")
                    if let imageData = imageData {
                        data = imageData
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }.resume()
        return data
    }
}
