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

    func updateOrder(order: Order) async throws -> Order {
        guard let url = URL(string: Endpoints.updateOrder(order.id!).path, relativeTo: baseURL) else {
            throw NetworkError.badURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(order)

        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw NetworkError.badRequest
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badRequest
        }

        guard let updatedOrder = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }

        return updatedOrder
    }

    func deleteOrder(id: Int) async throws -> Order {
        guard let url = URL(string: Endpoints.deleteOrder(id).path, relativeTo: baseURL) else {
            throw NetworkError.badURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badRequest
        }

        guard let deletedOrder = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }

        return deletedOrder
    }

    func placeOrder(order: Order) async throws -> Order {
        guard let url = URL(string: Endpoints.placeOrder.path, relativeTo: baseURL) else { throw NetworkError.badURL }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(order)

        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw NetworkError.badRequest
        }

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badRequest
        }

        guard let order = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }

        return order
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
