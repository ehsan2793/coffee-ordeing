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
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()

        XCTAssertEqual("No Orders available", app.staticTexts["noOrdersText"].label)
    }
}

final class when_adding_a_new_coffee_order: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        
        app.buttons["addNewOrderButton"].tap()
        
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.textFields["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("Jpn")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Coffee")
        
        priceTextField.tap()
        priceTextField.typeText("4.50")
        
//        placeOrderButton.tap()
    }
    
    func test_should_display_coffee_order_in_list() throws {
//        XCTAssertEqual("Jpn", app.staticTexts["OrderNameText"].label)
//        XCTAssertEqual("Coffee", app.staticTexts["CoffeeNameAndSizeText"].label)
//        XCTAssertEqual("4.50 (Medium)", app.staticTexts["CoffeePriceText"].label)
//        XCTAssertEqual("$4.50", app.staticTexts["orderNameTexT"].label)
    }
    
    override func tearDown() {
        super.tearDown()
        Task {
            guard let url = URL(string: "/clear-order", relativeTo: URL(string: "https://island-bramble.glitch.me/test")!) else {return }
            let (_,_) = try! await URLSession.shared.data(from: url)
        }
    }
}
