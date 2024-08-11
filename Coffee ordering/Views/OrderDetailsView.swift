//
//  OrderDetailsView.swift
//  Coffee ordering
//
//  Created by Ehsan Rahimi on 8/10/24.
//

import SwiftUI

struct OrderDetailsView: View {
    let orderId: Int
    @State private var isPresented: Bool = false
    @Environment(CoffeeModel.self) var model
    @Environment(\.dismiss) private var dismiss

    func deleteOrder() async {
        do {
            try await model.deleteOrder(orderId)
            dismiss()
        } catch {
            print(error)
        }
    }

    var body: some View {
        VStack {
            if let order = model.orderById(id: orderId) {
                VStack(alignment: .leading, spacing: 10.0) {
                    Text(order.coffeeName)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("CoffeNameText")

                    Text(order.size.rawValue)
                        .foregroundStyle(.secondary)

                    Text(order.total as NSNumber, formatter: NumberFormatter.currency)

                    HStack {
                        Spacer()
                        Button("Delete Order", role: .destructive) {
                            Task {
                                await deleteOrder()
                            }
                        }
                        Button("Edit Order") {
                            isPresented = true
                        }
                        .accessibilityIdentifier("EditOrderButton")

                        Spacer()
                    } //: HSTACK

                }.sheet(isPresented: $isPresented, content: {
                    AddCoffeeView(order: order)
                })
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    var config = Configration()
    let webservice = WebService(baseURL: config.environment.baseURL)
    let model: CoffeeModel = CoffeeModel(webservice: webservice)
    return OrderDetailsView(orderId: 1)
        .environment(model)
}
