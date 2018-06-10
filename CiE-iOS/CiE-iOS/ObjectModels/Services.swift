//
//  Services.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 25.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import Foundation
import UIKit

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

enum ConflictIndicator: String {
    case time = "Time"
    case location = "Location"
    case other = "Other"
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


struct FavouriteService {
    static var currentFavourites: [Lecture] = { return favourites }()
    static private var favourites: [Lecture] = []
    
    static func add(_ lecture: Lecture) {
        for favourite in favourites { guard favourite != lecture else { return } }
        favourites.append(lecture)
    }
    
    static func remove(_ lecture: Lecture) {
        for (index,favourite) in favourites.enumerated() {
            if favourite == lecture { favourites.remove(at: index) }
        }
    }
    
}

struct AlertService {
    static func showConfirmAlert(
        titled title: String,
        withSubtitle subtitle: String,
        onCancel cancleClosure: @escaping (UIAlertAction) -> Void,
        onConfirm okClosure: @escaping (UIAlertAction) -> Void
        ) -> UIAlertController {
        let myAlertController: UIAlertController = UIAlertController(
            title: title,
            message: subtitle,
            preferredStyle: .alert
        )
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) {
            action -> Void in
            cancleClosure(action)
        }
        let nextAction: UIAlertAction = UIAlertAction(title: "Confirm", style: .default) {
            action -> Void in
            okClosure(action)
        }
        
        myAlertController.addAction(cancelAction)
        myAlertController.addAction(nextAction)
        return myAlertController
    }
}

