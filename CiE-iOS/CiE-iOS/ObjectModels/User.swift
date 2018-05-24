//
//  User.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 18.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

protocol UserProtocol {
    init(withName name: String, andPassword: String)
    var name:String { get }
    var password: String { get }
    var isExchange: Bool? { get }
    var departments: Set<Department> { get }
    
    func changePassword(to: String)
    func becomeExchangeStudent()
    func assignDepartments(_: Set<Department>?)
    func assignDepartments(_: [Department]?)
    
}

enum Department: Int {
    case FK01 = 1, FK02, FK03, FK04, FK05, FK06, FK07, FK08, FK09, FK10, FK11, FK12, FK13
}

class User: UserProtocol {
    public private(set) var name: String
    public private(set) var password: String
    public private(set) var isExchange: Bool? = false
    
    public private(set) var departments: Set<Department> = []
    
    required init(withName name: String, andPassword password: String) {
        self.name = name
        self.password = password
    }

    func changePassword(to newPassword: String) {
        password = newPassword
    }
    
    func becomeExchangeStudent() {
        isExchange = true
    }
    
    func assignDepartments(_ assignedDepartments: Set<Department>?) {
        guard let assignedDepartments = assignedDepartments else { return }
        if !departments.isEmpty {
            for department in assignedDepartments {
                departments.update(with: department)
            }
        } else {
            departments = assignedDepartments
        }
    }
    
    func assignDepartments(_ assignedDepartments: [Department]?) {
        guard let assignedDepartments = assignedDepartments else { return }
        var allAssignedDepartments = assignedDepartments
        if !departments.isEmpty {
            for department in departments {
                allAssignedDepartments.append(department)
            }
        }
        departments = Set(allAssignedDepartments)
    }
    
}
