//
//  Coffee_orderingApp.swift
//  Coffee ordering
//
//  Created by Ehsan Rahimi on 8/3/24.
//

import SwiftUI

@main
struct Coffee_orderingApp: App {
    @State private var model: CoffeeModel = CoffeeModel(webservice: WebService())
 
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
        }
    }
}
