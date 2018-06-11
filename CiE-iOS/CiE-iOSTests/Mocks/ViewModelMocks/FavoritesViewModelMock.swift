//
//  FavoritesViewModelMock.swift
//  CiE-iOSTests
//
//  Created by Nikita Hans on 10.06.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import Foundation

@testable import CiE_iOS

class FavouritesViewModelMock: FavoritesViewModelProtocol {
    
    var favourites: [LectureProtocol] { return injectedFavourites }
    var hasConflicts: Bool { return injectedHasConflicts }
    var conflictForAlert: FavouriteConflict? { return injectedConflictForAlert }
    
    var injectedFavourites: [LectureProtocol] = []
    var injectedHasConflicts: Bool = false
    var conflictForAlert: FavouriteConflict? = nil 
    
    init(){}
}
