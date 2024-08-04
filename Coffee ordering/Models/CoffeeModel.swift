//
//  CoffeeModel.swift
//  Coffee ordering
//
//  Created by Ehsan Rahimi on 8/4/24.
//

import Foundation
import Observation

//@MainActor
@Observable class CoffeeModel {
    let webservice: WebService
    private(set) var orders: [Order] = []

    init(webservice: WebService) {
        self.webservice = webservice
    }

    func populateOrders() async throws {
        orders = try await webservice.getOrders()
    }
}
