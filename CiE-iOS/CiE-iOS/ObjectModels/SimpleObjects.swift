//
//  SimpleObjects.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 10.06.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import Foundation
import UIKit

enum LectureAvailability {
    func getImage() -> UIImage? {
        switch self {
        case .available:
            return UIImage(named: "courses_green")?.withRenderingMode(.alwaysTemplate)
        case .endangerd:
            return UIImage(named: "courses_yellow")?.withRenderingMode(.alwaysTemplate)
        case .unavailable:
            return UIImage(named: "courses_red")?.withRenderingMode(.alwaysTemplate)
        }
    }
    func getColor() -> UIColor {
        switch self {
        case .available:
            return UIColor.green.withAlphaComponent(0.7)
        case .endangerd:
            return UIColor.orange.withAlphaComponent(0.7)
        case .unavailable:
            return UIColor.red.withAlphaComponent(0.7)
        }
    }
    case available
    case endangerd
    case unavailable
}
enum Department: Int {
    case FK01 = 1, FK02, FK03, FK04, FK05, FK06, FK07, FK08, FK09, FK10, FK11, FK12, FK13
    case Undefined = -1
    
    func getString() -> String {
        guard rawValue != -1 else { return "Undefined" }
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
    
    func getTimeBoxString() -> String? {
        let components = Calendar.current.dateComponents([.hour, .minute], from: self.date)
        guard let hour = components.hour, let minute = components.minute else { return nil }
        let durationMinutes = hour*60 + minute + Int(self.duration * 60)
        let hoursEnd = durationMinutes/60 <= 9 ? "0\(durationMinutes/60)" : "\(durationMinutes/60)"
        let minutesEnd = durationMinutes % 60 <= 9 ? "0\(durationMinutes%60)" : "\(durationMinutes%60)"
        return "\(hour <= 9 ? "0\(hour)" : "\(hour)"):\(minute <= 9 ? "0\(minute)" : "\(minute)") - \(hoursEnd):\(minutesEnd)"
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

