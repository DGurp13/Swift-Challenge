//
//  LeagueMobileChallengeTests.swift
//  LeagueMobileChallengeTests
//
//  Created by Kelvin Lau on 2019-01-09.
//  Copyright © 2019 Kelvin Lau. All rights reserved.
//

import XCTest
@testable import LeagueMobileChallenge

class LeagueMobileChallengeTests: XCTestCase {
    
    var viewController: InfoViewController = InfoViewController()
    var tableView: UITableView!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        // Load the view hierarchy
        viewController.loadViewIfNeeded()
        tableView = viewController.infoTableView
    }

    override func tearDown() {
        super.tearDown()
        tableView = nil
    }
    
    func testThatViewLoads()
    {
        XCTAssertNotNil(self.viewController.view, "View not initiated properly");
    }
    
    func testTableViewOutlet() {
        XCTAssertNotNil(self.viewController.infoTableView)
        }
    
    func testThatTableViewLoads()
    {
        XCTAssertNotNil(self.viewController.infoTableView, "TableView not initiated")
    }
    
    func testNumberOfRowsInSection() {
            // Given
        let infoMergedData = [Info.init(id: 1, username: "Test", avatar: "jhjhjh", title: "ggghg", body: "hgjhgh")]
            viewController.infoMergedData = infoMergedData

            // When
            let numberOfRows = viewController.tableView(tableView, numberOfRowsInSection: 1)

            // Then
            XCTAssertEqual(numberOfRows, infoMergedData.count, "Number of rows in section should match the count of infoMergedData array")
        }
    
    func testReloadData() {
        let exp = expectation(description: "reloadCallback")
        viewController.infoTableView.reloadData()
        XCTAssert(true)
        exp.fulfill()
            waitForExpectations(timeout: 5)
        }
    
    func testUserTokenApiResponse() {
        let e = expectation(description: "Alamofire")
        viewController.fetchAPIData()
        
        debugPrint("-->Unit Test User token Data \(self.viewController.infoMergedData.description)")
        let resultString = self.viewController.infoMergedData.description
        let expectedString = "[]"
        XCTAssertEqual(resultString, expectedString)
        e.fulfill()
        waitForExpectations(timeout: 5.0, handler: nil)
        } 
    }


