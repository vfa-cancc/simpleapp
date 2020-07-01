//
//  HuCaChat_DevUITests.swift
//  HuCaChat_DevUITests
//
//  Created by HungNV on 6/30/20.
//  Copyright © 2020 HungNV. All rights reserved.
//

import XCTest

class HuCaChat_DevUITests: XCTestCase {

    let app = XCUIApplication()
    static let kUserInfo = "UI-TestingKey_kUserInfo"
    
    // MARK: - Setup for UI Test
    override func setUp() {
        continueAfterFailure = false
        app.launchArguments.append("UI-Testing")
        app.launchEnvironment[HuCaChat_DevUITests.kUserInfo] = "NO"
        app.launch()
    }

    /// Test all app
    func testAllApp() {
        self.testLogin()
        self.testHomeScreen()
    }
    
    /// test login screen
    private func testLogin() {
        let tfUsername = app.textFields["tfUsername"]
        XCTAssert(tfUsername.exists)
        self.tapElementAndWaitForKeyboardToAppear(tfUsername)
        tfUsername.typeText("vfa.hungnv@gmail.com")
        
        let tfPassword = app.secureTextFields["tfPassword"]
        XCTAssert(tfPassword.exists)
        self.tapElementAndWaitForKeyboardToAppear(tfPassword)
        tfPassword.typeText("123456")
        
        let btnLogin = app.buttons["btnLogin"]
        XCTAssert(btnLogin.exists)
        self.waitForElementToAppear(btnLogin)
        btnLogin.tap()
        
        /// Logout
        let leftBar: XCUIElement = app.navigationBars.buttons.element(boundBy: 0)
        self.waitForElementToAppear(leftBar) /// Wait for element load finished
        leftBar.tap()
        
        let btnLogout = app.buttons["btnLogout"]
        XCTAssert(btnLogout.exists)
        btnLogout.tap()
    }
    
    private func testHomeScreen() {
//        let tableView = app.tables.containing(.table, identifier: "tableView")
//        XCTAssertTrue(tableView.cells.count > 2)
//        let cell = tableView.cells.element(boundBy: 2)
//        self.waitForElementToAppear(tableView)
//        cell.tap()
    }
    
    override func tearDown() {
        /// Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    // MARK: - Other method
        
    /// Wait for element/ui to appear
    private func waitForElementToAppear(_ element: XCUIElement, file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: 5) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after 5 seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
            }
        }
    }

    /// Wait for keyboard to appear
    private func tapElementAndWaitForKeyboardToAppear(_ element: XCUIElement) {
        let keyboard = XCUIApplication().keyboards.element
        while (true) {
            element.tap()
            if keyboard.exists {
                break;
            }
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.5))
        }
    }
}
