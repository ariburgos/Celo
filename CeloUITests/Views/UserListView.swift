//
//  UserListView.swift
//  CeloUITests
//
//  Created by Viajeros Lado B on 20/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import XCTest

struct UserListView {
    static let app = XCUIApplication()
    static let table = app.tables.firstMatch
    static let firstCell = table.cells.firstMatch
    static let firstCellTitle = firstCell.staticTexts["title"]
    
    static func tapFirstCell() -> UserDetailsView.Type {
        firstCell.tap()
        return UserDetailsView.self
    }
}
