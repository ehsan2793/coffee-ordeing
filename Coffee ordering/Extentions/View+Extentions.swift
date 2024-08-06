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

    @ViewBuilder
    func visable(_ value: Bool) -> some View {
        switch value {
        case true:
            self
        default:
            EmptyView()
        }
    }
}
