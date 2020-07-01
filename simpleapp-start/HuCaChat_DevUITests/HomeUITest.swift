//
//  HomeUITest.swift
//  HuCaChat_DevUITests
//
//  Created by HungNV on 7/1/20.
//  Copyright © 2020 HungNV. All rights reserved.
//

import XCTest

class HomeUITest: XCTestCase {
    let app = XCUIApplication()
    
    func testHomeScreen() {
        let leftBar: XCUIElement = app.navigationBars.buttons.element(boundBy: 0)
        leftBar.tap()
        
        let btnLogout = app.buttons["btnLogout"]
        XCTAssert(btnLogout.exists)
        btnLogout.tap()
    }
}
