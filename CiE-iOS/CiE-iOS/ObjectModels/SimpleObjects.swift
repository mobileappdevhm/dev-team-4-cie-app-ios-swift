//
//  SimpleObjects.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 10.06.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import Foundation

enum Department: Int {
    case FK01 = 1, FK02, FK03, FK04, FK05, FK06, FK07, FK08, FK09, FK10, FK11, FK12, FK13
    
    func getString() -> String {
        return self.rawValue < 10 ? "FK0\(self.rawValue)" : "FK\(self.rawValue)"
    }
}

struct Room {
    let floor: Floor
    let onlyDisplayName: Bool
    var number: Int? {
        return onlyDisplayName ? nil : _internalNumber
    }
    let _internalNumber: Int
    let building: Building
    public private(set) var displayName: String
    
    func getNameRepresentation() -> String {
        if onlyDisplayName {
            return displayName
        }
        return "\(building.rawValue) \(floor.rawValue).\(_internalNumber)"
    }
    
    init(stringRepresentation displayName: String) {
        self.displayName = displayName
        floor = .Undefined
        building = .Undefined
        _internalNumber = 123
        onlyDisplayName = true
    }
    
    init(floor: Floor, number: Int, building: Building) {
        onlyDisplayName = false
        self.floor = floor
        self._internalNumber = number
        self.building = building
        displayName = ""
        displayName = getNameRepresentation()
    }
}

enum Floor: Int {
    case Basement = -1, GroundFloor, FirstFloor, SecondFloor, ThirdFloor, FourthFloor
    case Undefined = -100
}

enum Building: String {
    case A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
    case Undefined
}

struct LectureDate: Hashable {
    static func == (lhs: LectureDate, rhs: LectureDate) -> Bool {
        return lhs.date == rhs.date && rhs.room.getNameRepresentation() == lhs.room.getNameRepresentation()
    }
    
    var hashValue: Int
    
    let room: Room
    let date: Date
    let duration: Double
    
    init(room: Room, date: Date, durationInHours: Double) {
        self.room = room
        self.date = date
        self.duration = durationInHours
        self.hashValue = room._internalNumber * room.floor.rawValue / 7
    }
}

struct Impact {
    let ects: Int
    let cie: Int
    init(changingEctsBy ects: Int, changingCiEBy cie: Int) {
        self.ects = ects
        self.cie = cie
    }
}

enum ConflictIndicator: String {
    case time = "Time"
    case location = "Location"
    case other = "Other"
    static func generalDescription(_ indicator: ConflictIndicator) -> String {
        switch indicator {
        case .other:
            return "Some unknown Conflict detected."
        case .location, .time:
            return "Some sort of \(indicator.rawValue)-Conflict detected."
        }
    }
}

enum Gender: String {
    case male, female
}

struct FavouriteConflict {
    let lectureA: Lecture
    let lectureB: Lecture
    let reason: ConflictIndicator
    
    init(between A: Lecture, and B: Lecture, becauseOf reason: ConflictIndicator) {
        lectureA = A
        lectureB = B
        self.reason = reason
    }
    
    func alertDescription() -> String {
        return "\(reason.rawValue)-Conflicts between Lecture \(lectureA.title) and \(lectureB.title) detected."
    }
}

