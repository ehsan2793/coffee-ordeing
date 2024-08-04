//
//  WebService.swift
//  Coffee ordering
//
//  Created by Ehsan Rahimi on 8/3/24.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case decodingError
    case badRequest
}

class WebService {
    func getOrders() async throws -> [Order] {
        let urlString = "https://island-bramble.glitch.me/test/orders"
        guard let url = URL(string: urlString) else { throw NetworkError.badURL }

        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw NetworkError.badRequest
        }

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NetworkError.badRequest
        }
        guard let orders = try? JSONDecoder().decode([Order].self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return orders
    }
}
