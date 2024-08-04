//
//  ContentView.swift
//  Coffee ordering
//
//  Created by Ehsan Rahimi on 8/3/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(CoffeeModel.self) private var model

    func populateOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            print(error)
        }
    }

    var body: some View {
        VStack {
            List(model.orders) { order in
                OrderCellView(order: order)
            }
        }
        .task {
            await populateOrders()
        }
    }
}

#Preview {
    ContentView()
        .environment(CoffeeModel(webservice: WebService()))
}
