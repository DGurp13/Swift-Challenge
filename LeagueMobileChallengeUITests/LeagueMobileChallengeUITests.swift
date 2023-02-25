//
//  LeagueMobileChallengeUITests.swift
//  LeagueMobileChallengeUITests
//
//  Created by Kelvin Lau on 2019-01-09.
//  Copyright © 2019 Kelvin Lau. All rights reserved.
//

import XCTest

class LeagueMobileChallengeUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {

    }

    func testTableView() {
        
        let app = XCUIApplication()
        let inProgressActivityIndicator = app.tables["In progress"].activityIndicators["In progress"]
        inProgressActivityIndicator.swipeUp()
        inProgressActivityIndicator.swipeDown()
    }
    
    func testLaunchApplication() throws {
            if #available(iOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                                XCUIApplication().launch()
            }
        }
    }

}
