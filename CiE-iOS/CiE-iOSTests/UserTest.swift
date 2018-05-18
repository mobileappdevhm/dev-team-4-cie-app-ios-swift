//
//  UserTest.swift
//  CiE-iOSTests
//
//  Created by Nikita Hans on 18.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import XCTest
@testable import CiE_iOS

class UserTest: XCTestCase {
    
    var user: UserProtocol?
    let userName = "Manuel Neuer"
    
    override func setUp() {
        super.setUp()
        user = User(userName)
    }
    
    override func tearDown() {
        super.tearDown()
        user = nil
    }
    
    func testgetName_userHasBeenIntialized_ReturnsNameInitializedWith() {
        guard let user = user else { return }
        XCTAssertEqual(user.name, userName)
    }
    
}
