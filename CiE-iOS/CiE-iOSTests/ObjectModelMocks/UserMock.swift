//
//  UserMock.swift
//  CiE-iOSTests
//
//  Created by Nikita Hans on 18.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import Foundation
@testable import CiE_iOS


class UserMock: UserProtocol {
    init() {}
    required init(withName name: String, andPassword: String) {}
    
    var name: String { return injectedName}
    var password: String { return injectedPassword}
    var isExchange: Bool? { return injectedIsExchange}
    var departments: Set<Department> { return injectedDepartments}
    
    var injectedName: String = ""
    var injectedPassword: String = ""
    var injectedIsExchange: Bool = true
    var injectedDepartments: Set<Department> = []
    
    func changePassword(to: String) {}
    
    func becomeExchangeStudent() {}
    
    func assignDepartments(_: Set<Department>?) {}
    
    func assignDepartments(_: [Department]?) {}
}
