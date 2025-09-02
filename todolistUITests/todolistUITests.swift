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

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testAddAndDeleteTodo() throws {
        // Launch the application
        let app = XCUIApplication()
        app.launch()
        
        // Verify the navigation title exists
        XCTAssertTrue(app.navigationBars["Todo List"].exists)
        
        // Find the text field and add button
        let textField = app.textFields["Add new todo..."]
        let addButton = app.buttons.containing(.image, identifier: "plus.circle.fill").element
        
        // Verify initial state - add button should be disabled
        XCTAssertTrue(textField.exists)
        XCTAssertTrue(addButton.exists)
        XCTAssertFalse(addButton.isEnabled)
        
        // Type a todo item
        textField.tap()
        textField.typeText("Buy groceries")
        
        // Add button should now be enabled
        XCTAssertTrue(addButton.isEnabled)
        
        // Tap the add button
        addButton.tap()
        
        // Verify the todo appears in the list
        let todoText = app.staticTexts["Buy groceries"]
        XCTAssertTrue(todoText.exists)
        
        // Verify the text field is cleared
        XCTAssertEqual(textField.value as? String, "")
        
        // Find and tap the delete button for the todo
        let deleteButton = app.buttons.containing(.image, identifier: "trash").element
        XCTAssertTrue(deleteButton.exists)
        deleteButton.tap()
        
        // Verify the todo is removed from the list
        XCTAssertFalse(todoText.exists)
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
