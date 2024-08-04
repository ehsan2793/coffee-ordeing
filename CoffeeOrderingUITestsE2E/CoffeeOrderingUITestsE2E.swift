//
//  CoffeeOrderingUITestsE2E.swift
//  CoffeeOrderingUITestsE2E
//
//  Created by Ehsan Rahimi on 8/4/24.
//

import XCTest

final class when_app_is_launched_with_no_orders: XCTestCase {
    
    func test_should_no_order_no_message_is_displayed() throws {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV" : "TEST"]
        app.launch()
        
        XCTAssertEqual("No Orders available", app.staticTexts["noOrdersText"].label)
    }
    
}
