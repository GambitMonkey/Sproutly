//
//  SproutlyUITests.swift
//  SproutlyUITests
//
//  Created by Deniz Turan Çağlarca on 6.08.2025.
//

import XCTest

final class SproutlyUITests: XCTestCase {

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
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testloginScreenAppears() {
        let app = XCUIApplication()
        app.launchArguments = ["-skipOnboarding"] // ✅ skip straight to login
        app.launch()
        
        // Verify Login screen shows
        XCTAssertTrue(app.textFields["usernameField"].exists)
        XCTAssertTrue(app.secureTextFields["passwordField"].exists)
        XCTAssertTrue(app.buttons["loginButton"].exists)
    }
}
