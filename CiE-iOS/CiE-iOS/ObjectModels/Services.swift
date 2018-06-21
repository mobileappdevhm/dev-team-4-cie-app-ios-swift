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
    
    static func calculateImpact() -> Impact {
        var ects = 0
        var cie = 0
        for favourite in favourites {
            cie += favourite.isCiE ?? false ? 1 : 0
            ects += favourite.ects ?? 0
        }
        return Impact(changingEctsBy: ects, changingCiEBy: cie)
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
    static func getUser() -> User? { return user }
    static func getCurrentLectures() -> [Lecture] { return lectures }
    static func getPreviousLectures()-> [Lecture] { return prevLectures }
    static var allLectures: [Lecture] = {
        var all = lectures
        all.append(contentsOf: prevLectures)
        return all
    }()
    static var user: User?
    
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

//This service provides the Lecture Data from the nine API
struct LectureCatalogService {
    
    //Structs with json parameters
    struct Course: Decodable, Equatable {
        
        static func == (lhs: LectureCatalogService.Course, rhs: LectureCatalogService.Course) -> Bool {
            switch(lhs.id,rhs.id) {
            case (nil,nil):
                return true
            case (nil,_):
                return false
            case (_,nil):
                return false
            case (_,_):
                return lhs.id == rhs.id
            }
        }
        
        let id: String?
        let description: String?
        let isCoterie: Bool?
        let hasHomeBias: Bool?
        let correlations: [CorrelationAPI]?
        let dates: [DateAPI]?
        let name: String?
        let shortName: String?
        //let actions: []
    }
    
    struct CorrelationAPI: Decodable {
        let organiser: String?
        let curriculum: String?
        
        func asDepartment() -> Department? {
            guard let fk = organiser else { return .Undefined }
            let offset = fk.index(fk.startIndex, offsetBy: 3)
            return Department.init(rawValue: Int(String(fk[offset...])) ?? -1)
        }
        //let actions: []
    }
    
    struct DateAPI: Decodable {
        
        func asLectureDate() -> LectureDate? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYYMMDDZHHmmssZ"
            guard
                let rooms = rooms, !rooms.isEmpty, let roomNumber = rooms[0].number,
                let begin = begin, let startDate = dateFormatter.date(
                    from: begin.replacingOccurrences(of: "T", with: "Z")),
                let end = end, let endDate = dateFormatter.date(
                    from: end.replacingOccurrences(of: "T", with: "Z")),
                let lecturer = lecturer, !lecturer.isEmpty,
                let duration = calcDurationInHours(from: startDate, to: endDate)
                else { return nil }
            return LectureDate(
                room: Room(stringRepresentation: roomNumber),
                date: startDate,
                durationInHours: duration
            )
        }
        
        private func calcDurationInHours(from start: Date, to end: Date) -> Double? {
            let components = Calendar.current.dateComponents(
                [.year, .month, .day, .hour, .minute],
                from: start, to: end)
            guard components.year == 0, components.month == 0, components.day == 0,
                let hours = components.hour, let minutes = components.minute else { return nil}
            switch(hours,minutes) {
            case (0,15), (0,30), (0,45):
                return Double(minutes)/60
            case (1...24,0), (1...24,15), (1...24,30), (1...24,45):
                return (Double(minutes) + Double(hours)*60)/60
            default:
                return nil
            }
        }
        
        let begin: String?
        let end: String?
        let isCanceled: Bool?
        let rooms: [RoomAPI]?
        let lecturer: [LecturerAPI]?
        //let actions: []
    }
    
    struct RoomAPI: Decodable {
        let number: String?
        let building: String?
        let campus: String?
        //let actions: []
    }
    
    struct LecturerAPI: Decodable {
        let lastName: String?
        //let actions: []
    }
    
    private static var codableLectures: Dictionary<String,Course> = Dictionary()
    private static var lectures: Dictionary<String,Lecture> = Dictionary()
    
    private static func convert(_ rawLecture: Course) -> Lecture {
        
        var professorName: String = "Unknown Professor"
        if let dates = rawLecture.dates, !dates.isEmpty {
            if let lecturers = dates[0].lecturer, !lecturers.isEmpty {
                professorName = lecturers[0].lastName ?? professorName
            }
        }
        
        var description: String = "No Description provided."
        if let rawDescription = rawLecture.description {
            let data = rawDescription.data(using: String.Encoding.unicode)!
            let htmlOriginDescription = try? NSAttributedString(data: data,
                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil).string
            description = htmlOriginDescription ?? description
        }
        let lecture = Lecture(
            withTitle: rawLecture.name ?? "Unknown Title",
            withDescription: description,
            heldBy: Professor(withName: professorName)
        )
        
        lecture.hasHomeBias = rawLecture.hasHomeBias
        lecture.isCoterie = rawLecture.isCoterie
        
        for date in rawLecture.dates ?? [] {
            lecture.add(date: date.asLectureDate())
        }
        
        for correlation in rawLecture.correlations ?? [] {
            if let department = correlation.asDepartment() {
                lecture.isConnedtedTo(departments: [department])
            }
            if !(lecture.isCiE ?? false), correlation.curriculum?.lowercased() == "cie" {
                lecture.setToCiE()
            }
        }
        
        return lecture
    }
    
    @discardableResult
    static func getLectures(withUpdate updateIsNeeded: Bool) -> [Lecture]? {
        if updateIsNeeded {
            updateLectures()
        }
        for (id,rawLecture) in codableLectures {
            if let oldLecture = lectures[id] {
                oldLecture.update(using: convert(rawLecture))
            } else {
                lectures[id] = convert(rawLecture)
            }
        }
        return lectures.count != 0 ? Array(lectures.values) : nil
    }
    
    static func updateLectures() {
        
        let jsonUrlString = "https://nine.wi.hm.edu/api/v2/courses/FK%2013/CIE/SoSe%2018" //Update if next semester is available!!!
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, err) in
            guard let data = data else { return }
            do {
                let responsedLectures = try JSONDecoder().decode([Course].self, from: data)
                for course in responsedLectures {
                    guard let id = course.id else { break }
                    if !codableLectures.keys.contains(id) {
                        codableLectures[id] = course
                    } else {
                        
                    }
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            }.resume()
    }
}
