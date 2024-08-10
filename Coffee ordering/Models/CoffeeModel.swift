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
}
