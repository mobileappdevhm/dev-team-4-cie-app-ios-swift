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
    
    private var setString:String?
    hjhlkj;lk
    required init(_ name: String) {}
    
    var name: String {
        guard let returnString = setString else { return "" }
        return returnString
    }
    
    @discardableResult
    func setName(to name:String) -> UserProtocol {
        setString = name
        return self
    }
    
    
    
}
