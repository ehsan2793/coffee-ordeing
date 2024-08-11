//
//  CoffeeModel.swift
//  Coffee ordering
//
//  Created by Ehsan Rahimi on 8/4/24.
//

import Foundation
import Observation

@Observable class CoffeeModel {
    let webservice: WebService
    //  private(set) mean that orders can only be set from inside of this class
    private(set) var orders: [Order] = []

    init(webservice: WebService) {
        self.webservice = webservice
    }

    func orderById(id: Int) -> Order? {
        guard let index = orders.firstIndex(where: { $0.id == id }) else {
            return nil
        }
        return orders[index]
    }

    func populateOrders() async throws {
        orders = try await webservice.getOrders()
    }

    func placeOrder(order: Order) async throws {
        let newOrder = try await webservice.placeOrder(order: order)
        orders.append(newOrder)
    }

    func deleteOrder(_ orderId: Int) async throws {
        let deletedOrder = try await webservice.deleteOrder(id: orderId)
        orders = orders.filter { $0.id != deletedOrder.id }
    }

    func updateOrder(order: Order) async throws {
        let updatedOrder = try await webservice.deleteOrder(id: order.id!)
        if let index = orders.firstIndex(where: { $0.id == updatedOrder.id! }) {
            orders[index] = updatedOrder
        } else {
            print("Did not find order with id of \(order.id!)")
        }
    }
}
