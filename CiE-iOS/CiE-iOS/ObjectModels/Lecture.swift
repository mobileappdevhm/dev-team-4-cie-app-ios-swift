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
    
    init(withTitle: String, heldBy: Professor)
    
    func setECTS(to: Int)
    func setToCiE()
    func isConnedtedTo(departments: [Department]?)
    func add(dates: [LectureDate]?)
    func add(date: LectureDate?)
}

class Lecture: LectureProtocol {
    public private(set) var id: UUID
    public private(set) var title: String
    public private(set) var connectedDepartments: [Department] = []
    public private(set) var lectureDates: Set<LectureDate> = []
    public private(set) var ects: Int?
    public private(set) var isCiE: Bool?
    
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
