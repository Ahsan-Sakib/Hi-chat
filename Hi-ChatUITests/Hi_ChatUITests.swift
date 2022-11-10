//
//  Hi_ChatUITests.swift
//  Hi-ChatUITests
//
//  Created by BJIT-SAKIB on 7/11/22.
//

import XCTest

final class Hi_ChatUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let emailAddressTextField = app/*@START_MENU_TOKEN@*/.textFields["Email Address..."]/*[[".scrollViews.textFields[\"Email Address...\"]",".textFields[\"Email Address...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/

        XCTAssertTrue(emailAddressTextField.exists)
        emailAddressTextField.tap()
        emailAddressTextField.typeText("abc in absdfhsdfhds")

        let passwordTextField = app.secureTextFields["Password...."]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("sfbs")

        let loginButton = app.buttons["Log In"]
        XCTAssertTrue(loginButton.exists)
        app.buttons["Log In"].tap()

        let alertDismiss = app.buttons["Dismiss"]
        XCTAssertTrue(alertDismiss.exists)

        emailAddressTextField.tap()
        emailAddressTextField.clearAndEnterText(text: "")
        emailAddressTextField.typeText("abc@gmail.com")

        passwordTextField.tap()
        passwordTextField.typeText("abc123")

        app.buttons["Log In"].tap()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}


extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
        self.typeText(text)
    }
}
