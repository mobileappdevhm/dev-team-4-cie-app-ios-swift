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
    
    func test_Name_UserHasBeenInitialized_UserStoredName() {
        XCTAssertEqual(sut?.name, initName)
    }
    
    func test_Password_UserHasBeenInitialized_UserStoredPassword() {
        XCTAssertEqual(sut?.password, initPassword)
    }
    
    func test_Departments_UserHasBeenInitialized_NoDepartments() {
        XCTAssertEqual(sut?.departments, [])
    }

    func test_ExchangeStudentIndicator_HasNoValueExplicitlySet_ReturnsFalse() {
        XCTAssertFalse(sut?.isExchange ?? true)
    }
    
    func test_ExchangeStudentIndicator_BecameExchangeStudent_ReturnsTrue() {
        sut?.becomeExchangeStudent()
        XCTAssert(sut?.isExchange ?? false)
    }
    
    func test_Departments_UserHasBeenGivenDepartmentsAsArray_DepartmentsThatWereGiven() {
        let givenArray: [Department] = [.FK01, .FK02]
        sut?.assignDepartments(givenArray)
        XCTAssertEqual(Set(givenArray),sut?.departments)
    }
    
    func test_Departments_UserHasBeenGivenDepartmentsAsSet_DepartmentsThatWereGiven() {
        var departmentSet = Set<Department>()
        departmentSet.update(with: .FK01)
        departmentSet.update(with: .FK02)
        sut?.assignDepartments(departmentSet)
        XCTAssertEqual(departmentSet, sut?.departments)
    }
}
