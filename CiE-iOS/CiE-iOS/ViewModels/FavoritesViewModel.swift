//
//  FavoritesViewModel.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 12.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

protocol FavoritesViewModelProtocol {
    var hasConflicts: Bool { get }
    var favourites: [LectureProtocol] { get }
    var conflictForAlert: FavouriteConflict? { get }
}

class FavoritesViewModel: FavoritesViewModelProtocol {
    public var hasConflicts: Bool {
        return conflictForAlert != nil
    }
    public var favourites: [LectureProtocol] {
        return FavouriteService.currentFavourites
    }
    public private(set) var conflictForAlert: FavouriteConflict?
    
    init() {
        conflictForAlert = FavouriteConflict(
            between: Lecture(withTitle: "A", heldBy: Professor()),
            and: Lecture(withTitle: "B", heldBy: Professor()),
            becauseOf: .time
        )
    }
}
