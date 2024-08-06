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
        Form {
            TextField("Name", text: $name)
                .accessibilityIdentifier("name")
            Text(errors.name)
                .visable(!errors.name.isEmpty)
                .font(.system(.caption,design: .rounded))
                .foregroundStyle(.red)
                .fontWeight(.semibold)

            TextField("Coffee Name", text: $coffeeName)
                .accessibilityIdentifier("coffeeName")
            Text(errors.coffeeName)
                .visable(!errors.coffeeName.isEmpty)
                .font(.system(.caption,design: .rounded))
                .foregroundStyle(.red)
                .fontWeight(.semibold)

            TextField("Price", text: $price)
                .accessibilityIdentifier("price")
            Text(errors.price)
                .visable(!errors.price.isEmpty)
                .font(.system(.caption,design: .rounded))
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
                }
            }
            .centerHorizontally()
            .accessibilityIdentifier("placeOrderButton")
        }
    }
}

#Preview {
    AddCoffeeView()
}
