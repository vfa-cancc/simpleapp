//
//  HuCaChat_DevUITests.swift
//  HuCaChat_DevUITests
//
//  Created by HungNV on 6/16/20.
//  Copyright © 2020 HungNV. All rights reserved.
//

import XCTest

class HuCaChat_DevUITests: XCTestCase {
    let app = XCUIApplication()
    static let kUserInfo = "UI-TestingKey_kUserInfo"
    
    // MARK: - Setup for UI Test
    override func setUp() {
        /// In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launchArguments.append("UI-Testing")
        app.launchEnvironment[HuCaChat_DevUITests.kUserInfo] = "NO"
        app.launch()
    }

    override func tearDown() {
        /// Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Handle UI Test
    
    /// Handle test all app
    func testAllApp() {
        self.testSignInVC()
        self.testLogoutVC()
        self.testSignInVC()
        self.testRightVC()
        self.testHomeVC()
        self.testMusicVC()
        self.testMapVC()
    }
    
    /// Handle test Login view controller
    private func testSignInVC() {
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
        btnLogin.tap()
    }
    
    /// Handle test Login view controller
    private func testLogoutVC() {
        /// Logout
        let leftBar: XCUIElement = app.navigationBars.buttons.element(boundBy: 0)
        self.waitForElementToAppear(leftBar) /// Wait for element load finished
        leftBar.tap()
        
        let btnLogout = app.buttons["btnLogout"]
        XCTAssert(btnLogout.exists)
        btnLogout.tap()
    }
    
    /// Handle test Right view controller, list all user in blacklist
    private func testRightVC() {
        /// Right bar
        let rightBar: XCUIElement = app.navigationBars.buttons.element(boundBy: 1)
        self.waitForElementToAppear(rightBar) /// Wait for element load finished
        rightBar.tap()
        
        let tableView = app.tables.containing(.table, identifier: "tableView")
        XCTAssertTrue(tableView.cells.count > 0)
        let firstCell = tableView.cells.element(boundBy: 0)
        firstCell.swipeRight()
        app.alerts.firstMatch.buttons.element(boundBy: 0).tap() /// Alert confirm not create.
        rightBar.tap()
    }
    
    /// Handle test Home view controller
    private func testHomeVC() {
        /// Send message
        let tableView = app.tables.containing(.table, identifier: "tableView")
        XCTAssertTrue(tableView.cells.count > 2)
        let cell = tableView.cells.element(boundBy: 2)
        cell.tap()
        let tvInputMessage = app.textViews["tvInputMessage"]
        XCTAssert(tvInputMessage.exists)
        self.tapElementAndWaitForKeyboardToAppear(tvInputMessage)
        tvInputMessage.typeText("VnIndex bứt phá 22 điểm, nhiều nhà đầu tư chạy hôm qua tiếc nuối ^^")
        let btnSend = app.buttons["btnSend"]
        XCTAssert(btnSend.exists)
        btnSend.tap()
        app.navigationBars["navigationBar"].buttons["leftBar"].tap()
        
        /// Move to Group view controller
        let btnGroup = app.buttons["btnCalendarBar"]
        XCTAssert(btnGroup.exists)
        btnGroup.tap()
        
        /// Move to Notification view controller
        let btnNotification = app.buttons["btnAlartBar"]
        XCTAssert(btnNotification.exists)
        btnNotification.tap()
        
        /// Move to Setting view controller
        let btnSetting = app.buttons["btnSettingBar"]
        XCTAssert(btnSetting.exists)
        btnSetting.tap()
        
        /// Touch Center button
        let btnCenter = app.buttons["btnCenterBar"]
        XCTAssert(btnCenter.exists)
        btnCenter.tap()
    }
    
    /// Handle test Music view controller
    private func testMusicVC() {
        let btnMusic = app.buttons["btnCameraBar"]
        XCTAssert(btnMusic.exists)
        btnMusic.tap()
        let sldTime = app.sliders["sldTime"]
        XCTAssert(sldTime.exists)
        sldTime.adjust(toNormalizedSliderPosition: 0.4)
        let btnPlay = app.buttons["btnPlay"]
        XCTAssert(btnPlay.exists)
        btnPlay.tap()
        let collectionView = app.collectionViews.element
        XCTAssertTrue(collectionView.cells.count > 0)
        collectionView.swipeLeft()
        collectionView.swipeRight()
        btnPlay.tap()
        app.navigationBars["navigationBar"].buttons["leftBar"].tap()
    }
    
    /// Handle test Map view controller
    private func testMapVC() {
        /// Touch Center button
        let btnCenter = app.buttons["btnCenterBar"]
        XCTAssert(btnCenter.exists)
        btnCenter.tap()
        let btnMap = app.buttons["btnVideoBar"]
        XCTAssert(btnMap.exists)
        btnMap.tap()
        app.navigationBars["navigationBar"].buttons["leftBar"].tap()
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

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
