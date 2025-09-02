//
//  todolistUITests.swift
//  todolistUITests
//
//  Created by Rich Downie on 9/1/25.
//

import XCTest

final class todolistUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it's important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIDevice.shared.orientation = .portrait
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testAddAndDeleteTodo() throws {
        // Launch the application
        let app = XCUIApplication()
        app.launch()
        
        // Wait for the app to load and verify the navigation title exists
        let navigationBar = app.navigationBars["Todo List"]
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 5.0), "Navigation bar should exist")
        
        // Find the text field and add button with waits using accessibility identifiers
        let textField = app.textFields["todoTextField"]
        XCTAssertTrue(textField.waitForExistence(timeout: 5.0), "Text field should exist")
        
        // Look for button by accessibility identifier
        let addButton = app.buttons["addTodoButton"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 5.0), "Add button should exist")
        
        // Verify initial state - add button should be disabled
        XCTAssertFalse(addButton.isEnabled, "Add button should be initially disabled")
        
        // Type a todo item
        textField.tap()
        textField.typeText("Buy groceries")
        
        // Wait for the button to become enabled
        let enabledPredicate = NSPredicate(format: "isEnabled == true")
        expectation(for: enabledPredicate, evaluatedWith: addButton, handler: nil)
        waitForExpectations(timeout: 3.0, handler: nil)
        
        // Tap the add button
        addButton.tap()
        
        // Wait for the todo to appear in the list
        let todoText = app.staticTexts["Buy groceries"]
        XCTAssertTrue(todoText.waitForExistence(timeout: 5.0), "Todo text should appear in list")
        
        // Find and tap the delete button for the todo using accessibility identifier
        let deleteButton = app.buttons["deleteTodoButton"]
        XCTAssertTrue(deleteButton.waitForExistence(timeout: 5.0), "Delete button should exist")
        deleteButton.tap()
        
        // Verify the todo is removed from the list
        let disappearPredicate = NSPredicate(format: "exists == false")
        expectation(for: disappearPredicate, evaluatedWith: todoText, handler: nil)
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
