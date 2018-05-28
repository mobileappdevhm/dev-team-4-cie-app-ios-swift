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
    
    let initName = "Manuel"
    let initPassword = "Swordfish"
    
    var sut: UserProtocol?
    
    override func setUp() {
        super.setUp()
        sut = User(withName: initName, andPassword: initPassword)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    //func test_UnitOfWork_StateUnderTest_ExpectedBehavior {
    //     XCTAssert(bool)
    //}
    
    func test_name_userHasBeenInitialized_userStoredName() {
        XCTAssertEqual(sut?.name, initName)
    }
    
    func test_password_userHasBeenInitialized_userStoredPassword() {
        XCTAssertEqual(sut?.password, initPassword)
    }
    
    func test_departments_userHasBeenInitialized_noDepartments() {
        XCTAssertEqual(sut?.departments, [])
    }

    func test_exchangeStudentIndicator_hasNoValueExplicitlySet_ReturnsFalse() {
        XCTAssertFalse(sut?.isExchange ?? true)
    }
    
    func test_exchangeStudentIndicator_becameExchangeStudent_ReturnsTrue() {
        sut?.becomeExchangeStudent()
        XCTAssert(sut?.isExchange ?? false)
    }
    
    func test_departments_userHasBeenGivenDepartmentsAsArray_departmentsThatWereGiven() {
        let givenArray: [Department] = [.FK01, .FK02]
        sut?.assignDepartments(givenArray)
        XCTAssertEqual(Set(givenArray),sut?.departments)
    }
    
    func test_departments_userHasBeenGivenDepartmentsAsSet_departmentsThatWereGiven() {
        var departmentSet = Set<Department>()
        departmentSet.update(with: .FK01)
        departmentSet.update(with: .FK02)
        sut?.assignDepartments(departmentSet)
        XCTAssertEqual(departmentSet, sut?.departments)
    }
}
