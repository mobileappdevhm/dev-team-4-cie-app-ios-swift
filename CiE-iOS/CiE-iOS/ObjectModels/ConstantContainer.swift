//
//  EnumCollection.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 25.05.18.
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

protocol ConstantContainerProtocol {
    
}

class ConstantContainer {
    
}

