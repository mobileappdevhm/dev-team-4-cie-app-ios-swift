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
    var name: String { return internalName }
    var password: String { return internalPassword }
    var isExchange: Bool? {
        guard let isExchangeStudent = isExchangeStudent else { return false }
        return isExchangeStudent
    }
    var departments: Set<Department> {
        guard let internalDepartments = internalDepartments else { return [] }
        return internalDepartments
    }
    
    private var internalName: String
    private var internalPassword: String
    private var isExchangeStudent: Bool? = nil
    private var internalDepartments: Set<Department>?
    
    private var hasDepartments:Bool {
        if let _ = internalDepartments {
            return true
        }
        return false
    }
    
    required init(withName name: String, andPassword password: String) {
        internalName = name
        internalPassword = password
    }

    func changePassword(to newPassword: String) {
        internalPassword = newPassword
    }
    
    func becomeExchangeStudent() {
        isExchangeStudent = true
    }
    
    func assignDepartments(_ assignedDepartments: Set<Department>?) {
        guard let assignedDepartments = assignedDepartments else { return }
        if hasDepartments {
            for department in assignedDepartments {
                internalDepartments!.update(with: department)
            }
        } else {
            internalDepartments = assignedDepartments
        }
    }
    
    func assignDepartments(_ assignedDepartments: [Department]?) {
        guard let assignedDepartments = assignedDepartments else { return }
        var allAssignedDepartments = assignedDepartments
        if hasDepartments {
            for department in internalDepartments! {
                allAssignedDepartments.append(department)
            }
        }
        internalDepartments = Set(allAssignedDepartments)
    }
    
}
