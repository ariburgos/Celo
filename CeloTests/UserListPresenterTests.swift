//
//  UserListPresenterTests.swift
//  CeloTests
//
//  Created by Viajeros Lado B on 19/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import XCTest
import CoreData
@testable import Celo

class UserListPresenterTests: XCTestCase {
    private var userListPresenter: UsersListPresenter!
    private var userListView: UserListViewMock!
    private var userService: UsersServiceProtocol!
    
    func testShowNewUsers() {
        givenAUserListView()
        givenASuccessfullService()
        givenAUserListPresenter()
        whenPresenterPrefetchItems()
        thenAnLoadingIsDisplayed()
        thenAnLoadingIsDismissed()
        thenFetchCompleteIsCalled()
    }
    
    func testShowInvalidNewUsers() {
        givenAUserListView()
        givenAUnsuccessfullService()
        givenAUserListPresenter()
        whenPresenterPrefetchItems()
        thenAnLoadingIsDisplayed()
        thenAnLoadingIsDismissed()
        thenAnMessageIsDisplayed()
    }
    
    private func givenAUserListView() {
        userListView = UserListViewMock()
    }
    
    private func givenAUserListPresenter() {
        userListPresenter = UsersListPresenter(userService: userService)
        userListPresenter.attachView(view: userListView)
    }
    
    private func givenASuccessfullService() {
        userService = SuccessfullUserServiceMock()
    }
    
    private func givenAUnsuccessfullService() {
        userService = UnsuccessfullUserServiceMock()
    }
    
    private func whenPresenterPrefetchItems() {
        userListPresenter.prefetchItems()
    }
    
    private func thenFetchCompleteIsCalled() {
        XCTAssertTrue(userListView.fetchCompletedHasBeenCalled)
    }
    
    private func thenAnMessageIsDisplayed() {
        XCTAssertTrue(userListView.showMessageHasBeenCalled)
    }
    
    private func thenAnLoadingIsDisplayed() {
        XCTAssertTrue(userListView.showLoadingHasBeenCalled)
    }
    
    private func thenAnLoadingIsDismissed() {
        XCTAssertTrue(userListView.showLoadingHasBeenCalled)
    }
}

class SuccessfullUserServiceMock: NSObject, UsersServiceProtocol {
    func getUsers(page: Int, limit: Int, completion: @escaping ([UserViewModel]?, UsersAPI.UsersAPIError?) -> ()) {
        completion([],nil)
        
    }
}

class UnsuccessfullUserServiceMock: NSObject, UsersServiceProtocol {
    func getUsers(page: Int, limit: Int, completion: @escaping ([UserViewModel]?, UsersAPI.UsersAPIError?) -> ()) {
        completion(nil, nil)
    }
}

class UserListViewMock: NSObject, UserListViewProtocol {
    private(set) var fetchCompletedHasBeenCalled: Bool = false
    private(set) var reloadTableHasBeenCalled: Bool = false
    private(set) var showMessageHasBeenCalled: Bool = false
    private(set) var showLoadingHasBeenCalled: Bool = false
    private(set) var hideLoadingBeenCalled: Bool = false
    
    func onFetchCompleted(with indexPath: [IndexPath]) {
        fetchCompletedHasBeenCalled = true
    }
    
    func reloadTable() {
        reloadTableHasBeenCalled = true
    }
    
    func showMessage(message: String) {
        showMessageHasBeenCalled = true
    }
    
    func showLoading() {
        showLoadingHasBeenCalled = true
    }
    
    func hideLoading() {
        hideLoadingBeenCalled = true
    }
}
