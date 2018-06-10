//
//  Professor.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 25.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import Foundation

protocol ProfessorProtocol {
    var email: String? { get set }
    var name: String? { get set }
}

class Professor: ProfessorProtocol {
    var email: String?
    var name: String?
}
