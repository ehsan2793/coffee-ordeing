//
//  View+Extentions.swift
//  Coffee ordering
//
//  Created by Ehsan Rahimi on 8/5/24.
//

import Foundation
import SwiftUI

extension View {
    func centerHorizontally() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
}
