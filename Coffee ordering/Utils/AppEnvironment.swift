//
//  AppEnvironment.swift
//  Coffee ordering
//
//  Created by Ehsan Rahimi on 8/4/24.
//

import Foundation

enum AppEnvironment {
    case dev
    case test

    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "https://island-bramble.glitch.me")!
        case .test:
            return URL(string: "https://island-bramble.glitch.me/test")!
        }
    }
}

enum Endpoints {
    case allOrders
    case placeOrder
    case deleteOrder(Int)

    var path: String {
        switch self {
        case .allOrders:
            return "/orders"

        case .placeOrder:
            return "/orders"

        case let .deleteOrder(orderId):
            return "/orders/\(orderId)"
        }
    }
}

struct Configration {
    lazy var environment: AppEnvironment = {
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return AppEnvironment.dev
        }
        if env == "TEST" {
            return AppEnvironment.test
        }
        return AppEnvironment.dev
    }()
}
