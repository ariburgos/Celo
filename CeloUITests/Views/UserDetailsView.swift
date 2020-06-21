//
//  UserDetailsView.swift
//  CeloUITests
//
//  Created by Viajeros Lado B on 20/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import XCTest

struct UserDetailsView {
    static let app = XCUIApplication()
    static let backButton = app.navigationBars.firstMatch.buttons["Back"]
    static let scrollViews = app.scrollViews
    static let title = scrollViews.staticTexts["title"]

    static func tapBackButton() -> UserListView.Type {
        backButton.tap()
        return UserListView.self
    }
}
