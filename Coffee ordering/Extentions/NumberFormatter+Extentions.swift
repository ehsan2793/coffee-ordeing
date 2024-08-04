//
//  NumberFormatter+Extentions.swift
//  Coffee ordering
//
//  Created by Ehsan Rahimi on 8/4/24.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
