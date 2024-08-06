//
//  AddCoffeeView.swift
//  Coffee ordering
//
//  Created by Ehsan Rahimi on 8/5/24.
//

import SwiftUI

struct AddCoffeeView: View {
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CoffeeSize = .medium

    var body: some View {
        Form {
            TextField("Name", text: $name)
                .accessibilityIdentifier("name")

            TextField("Coffee Name", text: $coffeeName)
                .accessibilityIdentifier("coffeeName")

            TextField("Price", text: $price)
                .accessibilityIdentifier("price")

            Picker("Select Size", selection: $coffeeSize) {
                ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                    Text(size.rawValue).tag(size)
                }
            }
            .pickerStyle(.segmented)
            
            Button("Place Order") {
//
            }
            .centerHorizontally()
            .accessibilityIdentifier("placeOrderButton")
            
        }
    }
}

#Preview {
    AddCoffeeView()
}
