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

                Button("Place Order") {
                    if isValid {
                        Task {
                            await placeOrder()
                        }
                    }
                }
                .accessibilityIdentifier("placeOrderButton")
                .centerHorizontally()
            }
            .navigationTitle("Add Coffee")
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
