//
//  CeloUITests.swift
//  CeloUITests
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import XCTest

class CeloUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false

        let userListView = UserListView.self
        let _ = userListView.firstCell.waitForExistence(timeout: 0)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShowDetailView() {
        let app = XCUIApplication()
        app.launch()
        
        // GIVEN
        let userListView = UserListView.self
        
        
        // WHEN
        let firstRowName = userListView.firstCellTitle.label
        let detailView = userListView.tapFirstCell()
        let detailViewName = detailView.title.label
//        let popUserListView = detailView.tapBackButton()
        
        // THEN
        XCTAssertEqual(firstRowName, detailViewName)

    }
}
