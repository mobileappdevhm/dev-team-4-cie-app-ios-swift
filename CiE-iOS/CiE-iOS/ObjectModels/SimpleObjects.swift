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
}

struct Room {
    let floor: Floor
    let number: Int
    let building: Building
    
    func getNameRepresentation() -> String {
        return "\(building.rawValue) \(floor.rawValue).\(number)"
    }
    
    init(floor: Floor, number: Int, building: Building) {
        self.floor = floor
        self.number = number
        self.building = building
    }
}

enum Floor: Int {
    case Basement = -1, GroundFloor, FirstFloor, SecondFloor, ThirdFloor, FourthFloor
}

enum Building: String {
    case A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
}

struct LectureDate: Hashable {
    static func == (lhs: LectureDate, rhs: LectureDate) -> Bool {
        return lhs.date == rhs.date && rhs.room.getNameRepresentation() == lhs.room.getNameRepresentation()
    }
    
    var hashValue: Int
    
    let room: Room
    let date: Date
    
    init(room: Room, date: Date) {
        self.room = room
        self.date = date
        self.hashValue = room.number * room.floor.rawValue / 7
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

