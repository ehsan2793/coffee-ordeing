//
//  OrderCellView.swift
//  Coffee ordering
//
//  Created by Ehsan Rahimi on 8/4/24.
//

import SwiftUI

struct OrderCellView: View {
    let order: Order

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.name)
                    .accessibilityIdentifier("OrderNameText")
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .bold()
                Text("\(order.coffeeName) (\(order.size.rawValue))")
                    .accessibilityIdentifier("CoffeeNameAndSizeText")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                .accessibilityIdentifier("CoffeePriceText")
                .foregroundStyle(Color.accentColor)
                .font(.footnote)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    OrderCellView(order: Order(name: "Coffee", coffeeName: "Hot Mocha", total: 12.1, size: .small))
    
}
