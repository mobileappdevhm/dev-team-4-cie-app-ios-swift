//
//  LectureDetailViewModel.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 28.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

protocol LectureDetailViewModelProtocol {
    init(containing: LectureProtocol)
    var lecture: LectureProtocol { get }
    var title: String { get }
    var description: String { get }
    var contact: String? { get }
    
    func isFavourite() -> Bool
}

class LectureDetailViewModel: LectureDetailViewModelProtocol {
    public private(set) var lecture: LectureProtocol
    public private(set) var title: String
    public private(set) var description: String
    public private(set) var contact: String?
    
    func isFavourite() -> Bool {
        guard let lecture = lecture as? Lecture else { return false }
        return FavouriteService.currentFavourites().contains(lecture)
    }
    
    required init(containing lecture: LectureProtocol) {
        self.lecture = lecture
        title = lecture.title
        description = lecture.description
        contact = lecture.professor.email
    }
    
    
}
