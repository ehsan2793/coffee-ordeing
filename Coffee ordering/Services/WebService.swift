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
    private var baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    func getOrders() async throws -> [Order] {
        guard let url = URL(string: Endpoints.allOrders.path, relativeTo: baseURL) else { throw NetworkError.badURL }

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
