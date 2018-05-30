//
//  LectureDetailViewModel.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 28.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

protocol LectureDetailViewModelProtocol {
    init(containing: Lecture)
    var lecture: Lecture { get }
    var title: String { get }
    var description: String { get }
    var contact: String { get }
    
}

class LectureDetailViewModel: LectureDetailViewModelProtocol {
    
    public private(set) var lecture: Lecture
    public private(set) var title: String
    public private(set) var description: String
    public private(set) var contact: String
    
    required init(containing lecture: Lecture) {
        self.lecture = lecture
        title = lecture.title
        description = lecture.description
//        contact = lecture.professor
        contact = "email"
    }
    
    
}
