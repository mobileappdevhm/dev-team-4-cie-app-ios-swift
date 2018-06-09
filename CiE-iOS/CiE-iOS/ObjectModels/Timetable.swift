//
//  Timetable.swift
//  CiE-iOS
//
//  Created by Jack Tan on 8/6/18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class Timetables : Codable{
    let timetables: [Timetable]
    
    init(timetables: [Timetable]){
        self.timetables = timetables
    }
}

class Timetable: Codable {
    let course: String
    let time: String
    let room: String
    let campus: String
    
    init(course: String, time: String, room:String, campus:String){
        self.course = course
        self.time = time
        self.room = room
        self.campus = campus
        
    }
}
