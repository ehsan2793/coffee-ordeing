//
//  ContentView.swift
//  Coffee ordering
//
//  Created by Ehsan Rahimi on 8/3/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(CoffeeModel.self) private var model
    @State private var isPresented: Bool = false

    func populateOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            print(error)
        }
    }

    private func deleteOrder(_ indexSet: IndexSet) async {
        for index in indexSet {
            let order = model.orders[index]
            guard let orderId = order.id else { return }

            do {
                try await model.deleteOrder(orderId)
            } catch {
                print(error)
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                if model.orders.isEmpty {
                    Text("No Orders available")
                        .accessibilityIdentifier("noOrdersText")
                } else {
                    List {
                        ForEach(model.orders) { order in
                            VStack {
                                Text("\(order.id ?? 0)")
                                OrderCellView(order: order)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            Task {
                                await deleteOrder(indexSet)
                            }
                        })
                    }
                }
            }
            .task {
                await populateOrders()
            }
            .sheet(isPresented: $isPresented, content: {
                AddCoffeeView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isPresented = true
                    }, label: {
                        Image(systemName: "plus.square.fill")
                    })
                    .accessibilityIdentifier("addNewOrderButton")
                }
            }
            .navigationTitle("Orders")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    var config = Configration()
    let webservice = WebService(baseURL: config.environment.baseURL)
    let model: CoffeeModel = CoffeeModel(webservice: webservice)
    return ContentView()
        .environment(model)
}
