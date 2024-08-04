//
//  Coffee_orderingApp.swift
//  Coffee ordering
//
//  Created by Ehsan Rahimi on 8/3/24.
//

import SwiftUI

@main
struct Coffee_orderingApp: App {
    @State private var model: CoffeeModel

    init() {
        var config = Configration()
        let webservice = WebService(baseURL: config.environment.baseURL)
        model = CoffeeModel(webservice: webservice)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
        }
    }
}
