//
//  SettingsViewModel.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 12.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

protocol SettingsViewModelProtocol {
    init(withUser: User)
}

class SettingsViewModel: SettingsViewModelProtocol {
    public private(set) var user: User
    
    required init(withUser user: User) {
        self.user = user
    }
}
