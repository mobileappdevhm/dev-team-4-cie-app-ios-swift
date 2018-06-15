//
//  LectureMock.swift
//  CiE-iOSTests
//
//  Created by Nikita Hans on 25.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import Foundation

@testable import CiE_iOS

class LectureMock: LectureProtocol {
    
    var duration: Double? { return injectedDuration }
    
    var description: String { return injectedDescription }
    
    var id: UUID { return injectedUUID }
    var title: String { return injectedTitle }
    var connectedDepartments: [Department] { return injectedDepartments }
    var lectureDates: Set<LectureDate> { return injectedLectureDates }
    var ects: Int? { return injectedECTS }
    var isCiE: Bool? { return injectedIsCiE }
    var professor: ProfessorProtocol = Professor()
    var isSetUp: Bool { return injectedIsSetUp }

    var injectedUUID: UUID = UUID()
    var injectedTitle: String = ""
    var injectedDepartments: [Department] = []
    var injectedLectureDates: Set<LectureDate> = []
    var injectedECTS: Int?
    var injectedIsCiE: Bool?
    var injectedIsSetUp: Bool = false
    var injectedDescription: String = ""
    
    init() { self.professor = ProfessorMock()}
    
    required convenience init(withTitle: String, heldBy: ProfessorProtocol) { self.init() }
    
    func setECTS(to: Int) {}
    func setToCiE() {}
    func isConnedtedTo(departments: [Department]?) {}
    func add(dates: [LectureDate]?) { }
    func add(date: LectureDate?) { }
    
}
