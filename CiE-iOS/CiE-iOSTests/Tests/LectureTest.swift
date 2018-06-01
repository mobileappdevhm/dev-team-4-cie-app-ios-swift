//
//  LectureTest.swift
//  CiE-iOSTests
//
//  Created by Nikita Hans on 25.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import XCTest
@testable import CiE_iOS

class LectureTest: XCTestCase {
    let initTitle = "Vorlesung"
    let initProfessor = ProfessorMock()
    
    var sut: LectureProtocol?

    override func setUp() {
        super.setUp()
        sut = Lecture(withTitle: initTitle, heldBy: initProfessor)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil 
    }
    
    func test_Id_HasBeenInitialized_ReturnsID() {
        XCTAssertNotNil(sut?.id)
    }
    
    func test_Ects_NothingHasBeenSet_Returns() {
        XCTAssertNil(sut?.ects)
    }
    
    func test_Ects_HaveBeenSet_ReturnsSetValue() {
        let setValue = 12
        sut?.setECTS(to: setValue)
        XCTAssertEqual(sut?.ects, setValue)
        
        let setSecondValue = -34
        sut?.setECTS(to: setSecondValue)
        XCTAssertEqual(sut?.ects, setSecondValue)
        XCTAssertNotEqual(sut?.ects, setValue)
    }
    
    func test_IsSetUpState_HasNotBeenCompleted_ReturnsFalse() {
        XCTAssertFalse(sut?.isSetUp ?? true)
        sut?.add(date: LectureDate(
                    room: Room(floor: .Basement, number: 11, building: .R),
                    date: Date(timeIntervalSinceNow: 0.0)
                ))
        XCTAssertFalse(sut?.isSetUp ?? true)
        sut?.isConnedtedTo(departments: [.FK01])
        XCTAssertFalse(sut?.isSetUp ?? true)
        sut?.setToCiE()
        XCTAssertFalse(sut?.isSetUp ?? true)
    }
    
    func test_IsSetUpState_HasBeenCompleted_ReturnsTrue() {
        sut?.add(date: LectureDate(
            room: Room(floor: .Basement, number: 11, building: .R),
            date: Date(timeIntervalSinceNow: 0.0)
        ))
        sut?.isConnedtedTo(departments: [.FK01])
        sut?.setToCiE()
        sut?.setECTS(to: 20)
        XCTAssert(sut?.isSetUp ?? false)
    }
    
    func test_LectureDates_HasBeenInitialized_ReturnsEmptyArray() {
        XCTAssertEqual(
            sut?.lectureDates ??
                [LectureDate(room: Room(floor: .Basement, number: 11, building: .R),date: Date(timeIntervalSinceNow: 0.0))],
            []
        )
    }
    
    func test_LectureDates_HasLectureDatesAdded_ReturnsAddedLectureDates() {
        let setDepartments: [Department] = [.FK01, .FK04]
        sut?.isConnedtedTo(departments: setDepartments)
        XCTAssertEqual(sut?.connectedDepartments ?? [], setDepartments)
    }
    
    func test_Departments_HasBeenInitialized_ReturnsEmptyArray() {
        XCTAssertEqual(sut?.connectedDepartments ?? [.FK01], [])
    }
    
}
