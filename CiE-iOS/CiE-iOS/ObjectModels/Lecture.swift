//
//  Lecture.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 25.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import Foundation

protocol LectureProtocol {
    var id: UUID { get }
    var title: String { get }
    var connectedDepartments: [Department] { get }
    var lectureDates: Set<LectureDate> { get }
    var ects: Int? { get }
    var isCiE: Bool? { get }
    var professor: ProfessorProtocol { get set }
    var isSetUp: Bool { get }
    var description: String { get }
    var isCoterie:Bool? { get set }
    var hasHomeBias:Bool? { get set }
    var available: LectureAvailability { get }
    
    init(withTitle: String, withDescription: String?, heldBy: ProfessorProtocol)
    
    func setECTS(to: Int)
    func setToCiE()
    func isConnedtedTo(departments: [Department]?)
    func add(dates: [LectureDate]?)
    func add(date: LectureDate?)
    func update(using: Lecture) -> Lecture
    //func setID(to: String)
}

class Lecture: LectureProtocol,Equatable {
    public private(set) var id: UUID
    public private(set) var title: String
    public private(set) var connectedDepartments: [Department] = []
    public private(set) var lectureDates: Set<LectureDate> = []
    public private(set) var ects: Int?
    public private(set) var isCiE: Bool?
    public private(set) var description: String
    public var isCoterie: Bool?
    public var hasHomeBias: Bool?
    var professor: ProfessorProtocol
    var isSetUp: Bool {
        return !connectedDepartments.isEmpty
            && !lectureDates.isEmpty
            && ects != nil
            && isCiE != nil
    }
    var available: LectureAvailability {
        guard let coterie = isCoterie, let homeBias = hasHomeBias else { return .unavailable }
        switch (coterie,homeBias) {
        case (false,false):
            return .available
        case (false,true), (true,false):
            return .endangerd
        case (true,true):
            return .unavailable
        }
    }
    
    required init(withTitle title: String, withDescription description: String?, heldBy professor: ProfessorProtocol) {
        self.title = title
        self.professor = professor
        id = UUID()
        self.description = description ?? "No description was provided."
    }
    
    
    @discardableResult
    func update(using newVersion: Lecture) -> Lecture {
        title = newVersion.title
        connectedDepartments = newVersion.connectedDepartments
        lectureDates = newVersion.lectureDates
        ects = newVersion.ects
        isCiE = newVersion.isCiE
        description = newVersion.description
        return self
    }
    
    static func == (lhs: Lecture, rhs: Lecture) -> Bool {
        return lhs.id == rhs.id
    }

    func setECTS(to ects: Int) {
        self.ects = ects
    }
    
    func setToCiE() {
        isCiE = true
    }
    
    func isConnedtedTo(departments: [Department]?) {
        guard let departments = departments else { return }
        connectedDepartments.append(contentsOf: departments)
    }
    
    func add(dates: [LectureDate]?) {
        guard let dates = dates else { return }
        for date in dates {
            lectureDates.update(with: date)
        }
    }
    
    func add(date: LectureDate?) {
        guard let date = date else { return }
        lectureDates.update(with: date)
    }
    
}
