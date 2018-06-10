//
//  Services.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 25.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import Foundation
import UIKit

struct FavouriteService {
    static func currentFavourites() -> [Lecture] { return favourites }
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
    
    static func reset() {
        favourites = []
    }
}

struct UserStatsService {
    private enum UserStatType{
        case CiE
        case ECTS
    }
    
    static var currentLectures: [Lecture] = { return lectures }()
    static var previousLectures: [Lecture] = { return prevLectures}()
    static var allLectures: [Lecture] = {
        var all = lectures
        all.append(contentsOf: prevLectures)
        return all
    }()
    
    static func currentECTS() -> Int {
        return getAmount(of: .ECTS, forCurrent: true)
    }
    static func currentCiE() -> Int {
        return getAmount(of: .CiE, forCurrent: true)
    }

    static func previousECTS() -> Int {
        return getAmount(of: .ECTS, forCurrent: false)
    }
    static func previousCiE() -> Int {
        return getAmount(of: .CiE, forCurrent: false)
    }

    static func allECTS()  -> Int {
        return UserStatsService.currentECTS() + UserStatsService.previousECTS()
    }
    static func allCiE()  -> Int {
        return UserStatsService.currentCiE() + UserStatsService.previousCiE()
    }
    
    static private var lectures: [Lecture] = []
    static private var prevLectures: [Lecture] = []
    
    static func add(_ lecture: Lecture, forCurrentSemester current: Bool ) {
        addTargeted(lecture, forCurrent: current)
    }
    
    static func add(_ lectures: [Lecture], forCurrentSemester current: Bool) {
        for lecture in lectures {
            addTargeted(lecture, forCurrent: current)
        }
    }
    
    static func remove(_ lectures: [Lecture], forCurrentSemester current: Bool) {
        for lecture in lectures {
            removeTargeted(lecture, forCurrent: current)
        }
    }
    
    static func remove(_ lecture: Lecture, forCurrentSemester current: Bool) {
        removeTargeted(lecture, forCurrent: current)
    }
    
    private static func addTargeted(_ lecture: Lecture, forCurrent targetCurrent: Bool) {
        let data = targetCurrent ? lectures : prevLectures
        for alreadyAdded in data { guard alreadyAdded != lecture else { return } }
        targetCurrent ? lectures.append(lecture) : prevLectures.append(lecture)
    }
    
    private static func removeTargeted(_ lecture: Lecture, forCurrent targetCurrent: Bool) {
        let data = targetCurrent ? lectures : prevLectures
        for (index,alreadyAdded) in data.enumerated() {
            if alreadyAdded == lecture {
                _ = targetCurrent ? lectures.remove(at: index) : prevLectures.remove(at: index)
            }
        }
    }
    
    private static func getAmount(of requestType: UserStatType, forCurrent current: Bool) -> Int {
        var amount = 0
        var addingFunction: (Lecture) -> Int
        switch(requestType) {
        case .CiE:
            addingFunction = { lecture in
                return (lecture.isCiE ?? false) ? 1 : 0
            }
        case .ECTS:
            addingFunction = { lecture in
                return lecture.ects ?? 0
            }
        }
        let data = current ? lectures : prevLectures
        for lecture in data {
            amount += addingFunction(lecture)
        }
        return amount
    }
    
}

struct AlertService {
    static func showInfo(titled title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        return alert
    }
    
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
