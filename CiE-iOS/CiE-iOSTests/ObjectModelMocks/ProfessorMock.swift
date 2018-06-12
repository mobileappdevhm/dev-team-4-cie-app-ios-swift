//
//  ProfessorMock.swift
//  CiE-iOSTests
//
//  Created by Snezana Eckl on 30.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import Foundation
@testable import CiE_iOS

class ProfessorMock: ProfessorProtocol {
    
    init() {}
    required init(withName: String) {}
    
    var gender: Gender? {return injectedGender}
    var title: String? {return injectedTitle}
    var name: String {return injectedName}
    var email: String? {return injectedEmail}
    var department: Department? {return injectedDepartments}
    var room: Room? {return injectedRoom}
    
    var injectedGender: Gender?
    var injectedTitle: String = ""
    var injectedName: String = ""
    var injectedEmail: String = ""
    var injectedDepartments: Department?
    var injectedRoom: Room?
    
    func setGender(to: Gender) {}
    func setTitle(to: String) {}
    func setEmail(to: String) {}
    func setDepartment(to: Department) {}
    func setRoom(to: Room) {}

    
}
