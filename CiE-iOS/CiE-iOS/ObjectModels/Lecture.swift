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
    var professor: Professor { get set }
    var isSetUp: Bool { get }
    var description: String { get }
    
    init(withTitle: String, heldBy: Professor)
    
    func setECTS(to: Int)
    func setToCiE()
    func isConnedtedTo(departments: [Department]?)
    func add(dates: [LectureDate]?)
    func add(date: LectureDate?)
}

class Lecture: LectureProtocol,Equatable {
    
    static func == (lhs: Lecture, rhs: Lecture) -> Bool {
        return lhs.id == rhs.id
    }
    
    public private(set) var id: UUID
    public private(set) var title: String
    public private(set) var connectedDepartments: [Department] = []
    public private(set) var lectureDates: Set<LectureDate> = []
    public private(set) var ects: Int?
    public private(set) var isCiE: Bool?
    public private(set) var description: String
    
    var professor: Professor
    var isSetUp: Bool {
        return !connectedDepartments.isEmpty
            && !lectureDates.isEmpty
            && ects != nil
            && isCiE != nil
    }
    
    required init(withTitle title: String, heldBy professor: Professor) {
        self.title = title
        self.professor = professor
        id = UUID()
        self.description = "dummy description that actually is pretty long so you do not feel like its fake or anything. This just shows how much can be written here."
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
