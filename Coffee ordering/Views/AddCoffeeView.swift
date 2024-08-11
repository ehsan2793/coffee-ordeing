//
//  AddCoffeeView.swift
//  Coffee ordering
//
//  Created by Ehsan Rahimi on 8/5/24.
//

import SwiftUI

struct AddCoffeeErrors {
    var name: String = ""
    var coffeeName: String = ""
    var price: String = ""
}

struct AddCoffeeView: View {
    var order: Order? = nil
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CoffeeSize = .medium
    @State private var errors: AddCoffeeErrors = AddCoffeeErrors()
    @Environment(CoffeeModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    private func placeOrder() async {
        let order = Order(name: name, coffeeName: coffeeName, total: Double(price)!, size: coffeeSize)
        do {
            dismiss()
            try await model.placeOrder(order: order)
        } catch {
            print(error)
        }
    }

    var isValid: Bool {
        errors = AddCoffeeErrors()
        if name.isEmpty {
            errors.name = "Name can not be empty"
        }
        if coffeeName.isEmpty {
            errors.coffeeName = "Coffee Name can not be empty"
        }

        if price.isEmpty {
            errors.price = "Price can not be empty"
        } else if !price.isNumberic {
            errors.price = "Price needs to be a number"
        } else if !price.isLessThan(number: 1) {
            errors.price = "Price needs to be more than 1"
        }

        return errors.name.isEmpty && errors.coffeeName.isEmpty && errors.price.isEmpty
    }

    private func populateExistingOrder() {
        if let order = order {
            name = order.name
            coffeeName = order.coffeeName
            price = String(order.total)
            coffeeSize = order.size
        }
    }

    private func saveOrUpdate() async {
        if let order {
            var editOrder = order
            editOrder.name = name
            editOrder.coffeeName = coffeeName
            editOrder.size = coffeeSize
            editOrder.total = Double(price)!
            do {
                try await model.updateOrder(order: order)
                dismiss()
            } catch {
                print(error)
            }
        } else {
            await placeOrder()
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .accessibilityIdentifier("name")
                Text(errors.name)
                    .visable(!errors.name.isEmpty)
                    .font(.system(.caption, design: .rounded))
                    .foregroundStyle(.red)
                    .fontWeight(.semibold)

                TextField("Coffee Name", text: $coffeeName)
                    .accessibilityIdentifier("coffeeName")

                Text(errors.coffeeName)
                    .visable(!errors.coffeeName.isEmpty)
                    .font(.system(.caption, design: .rounded))
                    .foregroundStyle(.red)
                    .fontWeight(.semibold)

                TextField("Price", text: $price)
                    .accessibilityIdentifier("price")

                Text(errors.price)
                    .visable(!errors.price.isEmpty)
                    .font(.system(.caption, design: .rounded))
                    .foregroundStyle(.red)
                    .fontWeight(.semibold)

                Picker("Select Size", selection: $coffeeSize) {
                    ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                        Text(size.rawValue).tag(size)
                    }
                }
                .pickerStyle(.segmented)

                Button(order != nil ? "Edit Order" : "Place Order") {
                    if isValid {
                        Task {
                            await saveOrUpdate()
                        }
                    }
                }
                .accessibilityIdentifier("placeOrderButton")
                .centerHorizontally()
            }
            .navigationTitle(order != nil ? "Edit Order" : "Add Coffee")
            .onAppear {
                populateExistingOrder()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    var config = Configration()
    let webservice = WebService(baseURL: config.environment.baseURL)
    let model: CoffeeModel = CoffeeModel(webservice: webservice)
    return AddCoffeeView()
        .environment(model)
}
