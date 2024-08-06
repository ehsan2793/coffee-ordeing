//
//  String+Extentions.swift
//  Coffee ordering
//
//  Created by Ehsan Rahimi on 8/5/24.
//

import Foundation

extension String {
    var isNumberic: Bool {
        Double(self) != nil
    }

    func isLessThan(number: Double) -> Bool {
        if !self.isNumberic {
            return false
        }
        
        guard let value = Double(self) else { return false }
        
        return value > number
    }
}
