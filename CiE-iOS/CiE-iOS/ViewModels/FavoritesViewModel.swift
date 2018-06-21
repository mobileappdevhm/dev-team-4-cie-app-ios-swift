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
    var allECTS: Int { get }
    var allCiE: Int { get }
    var impact: Impact { get }
    func addFavourites()
    func clearFavourites()
    func update()
}

class FavoritesViewModel: FavoritesViewModelProtocol {
    public var hasConflicts: Bool {
        return conflictForAlert != nil
    }
    public var favourites: [LectureProtocol]
    public private(set) var conflictForAlert: FavouriteConflict?
    public var allECTS: Int { return UserStatsService.allECTS() }
    public var allCiE: Int { return UserStatsService.allCiE() }
    public var impact: Impact { return FavouriteService.calculateImpact() }
    public func addFavourites() {
        UserStatsService.add(FavouriteService.currentFavourites(), forCurrentSemester: true)
    }
    public func clearFavourites() {
        FavouriteService.reset()
    }
    public func update() {
        favourites = FavouriteService.currentFavourites()
    }
    
    init() {
        favourites = FavouriteService.currentFavourites()
//        conflictForAlert = FavouriteConflict(
//            between: Lecture(withTitle: "A", withDescription: nil, heldBy: Professor(withName: "A")),
//            and: Lecture(withTitle: "B", withDescription: nil, heldBy: Professor(withName: "B")),
//            becauseOf: .time
//        )
    }
}
