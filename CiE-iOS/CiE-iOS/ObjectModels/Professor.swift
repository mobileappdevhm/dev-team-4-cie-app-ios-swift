//
//  Professor.swift
//  CiE-iOS
//
//  Created by Snezana Eckl on 30.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import Foundation
    
protocol ProfessorProtocol {
    
    var gender: Gender? { get }
    var title: String? { get }
    var name: String { get }
    var email: String? { get }
    var department: Department? { get }
    var room: Room? { get }
    
    init(withName: String)
    
    func setGender(to: Gender)
    func setTitle(to: String)
    func setEmail(to: String)
    func setDepartment(to: Department)
    func setRoom(to: Room)
    
    }
    
class Professor: ProfessorProtocol {
    
    public private(set) var gender: Gender?
    public private(set) var title: String?
    public private(set) var name: String
    public private(set) var email: String?
    public private(set) var department: Department?
    public private(set) var room: Room?
    
    required init(withName name: String) {
        self.name = name
    }
    
    func setGender(to gender: Gender) {
        self.gender = gender
    }
    
    func setTitle(to title: String) {
        self.title = title
    }
    
    func setEmail(to email: String) {
        self.email = email
    }
    
    func setDepartment(to department: Department) {
        self.department = department
    }
    
    func setRoom(to room: Room) {
        self.room = room
    }
    
        
    }
