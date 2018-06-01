//
//  ProfessorTest.swift
//  CiE-iOSTests
//
//  Created by Snezana Eckl on 30.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import XCTest
@testable import CiE_iOS

class ProfessorTest: XCTestCase {
    
    let initName = "Socher"
    
    var sut: ProfessorProtocol?
    
    override func setUp() {
        super.setUp()
        sut = Professor(withName: initName)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    //func test_UnitOfWork_StateUnderTest_ExpectedBehavior {
    //     XCTAssert(bool)
    //}
    
    func test_Name_ProfessorHasBeenInitalized_ProfessorStoredName() {
        XCTAssertEqual(sut?.name, initName)
    }
    
    func test_Gender_HasBeenSet_ReturnsSetValue() {
        let setValue = Gender.male
        sut?.setGender(to: setValue)
        XCTAssertEqual(sut?.gender, setValue)
        
        let setSecondValue = Gender.female
        sut?.setGender(to: setSecondValue)
        XCTAssertEqual(sut?.gender, setSecondValue)
        XCTAssertNotEqual(sut?.gender, setValue)
    }
    
    func test_Gender_NothingHasBeenSet_Returns() {
        XCTAssertNil(sut?.gender)
    }
    
    func test_Title_HasBeenSet_ReturnsSetValue() {
        let setValue = "Prof. Dr. "
        sut?.setTitle(to: setValue)
        XCTAssertEqual(sut?.title, setValue)
        
        let setSecondValue = " "
        sut?.setTitle(to: setSecondValue)
        XCTAssertEqual(sut?.title, setSecondValue)
        XCTAssertNotEqual(sut?.title, setValue)
    }
    
    func test_Title_NothingHasBeenSet_Returns() {
        XCTAssertNil(sut?.title)
    }
    
    
    func test_Email_HasBeenSet_ReturnsSetValue() {
        let setValue = "socher@hm.edu"
        sut?.setEmail(to: setValue)
        XCTAssertEqual(sut?.email, setValue)
        
        let setSecondValue = "michael@hm.edu"
        sut?.setEmail(to: setSecondValue)
        XCTAssertEqual(sut?.email, setSecondValue)
        XCTAssertNotEqual(sut?.email, setValue)
    }
    
    func test_Email_NothingHasBeenSet_Returns() {
        XCTAssertNil(sut?.email)
    }
    
    func test_Department_HasBeenSet_ReturnsSetValue() {
        let setValue = Department.FK07
        sut?.setDepartment(to: setValue)
        XCTAssertEqual(sut?.department, setValue)
        
        let setSecondValue = Department.FK04
        sut?.setDepartment(to: setSecondValue)
        XCTAssertEqual(sut?.department, setSecondValue)
        XCTAssertNotEqual(sut?.department, setValue)
    }
    
    func test_Department_NothingHasBeenSet_Returns() {
        XCTAssertNil(sut?.department)
    }
 
}
