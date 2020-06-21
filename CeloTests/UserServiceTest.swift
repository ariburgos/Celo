//
//  UserServiceTest.swift
//  CeloTests
//
//  Created by Viajeros Lado B on 19/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import XCTest
import CoreData
@testable import Celo


class UserServiceTest: XCTestCase {
    private var userService: UsersService!
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Celo", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition( description.type == NSInMemoryStoreType )
            
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
    
    func testFetchItems() {
        let expect = expectation(description: "Fetch Users OK")
        
        givenAUserService()
        whenGetUsers(expectation: expect)
        thenExpectationIsCalled(expectation: expect)
    }
    
    private func givenAUserService() {
        userService = UsersService(container: mockPersistantContainer)
    }
    
    private func whenGetUsers(expectation: XCTestExpectation) {
        userService.getUsers(page: 1, limit: 20) { (users, error) in
            if let _ = users {
                expectation.fulfill()
            }
        }
    }
    
    private func thenExpectationIsCalled(expectation: XCTestExpectation) {
        wait(for: [expectation], timeout: 10)
    }
}
