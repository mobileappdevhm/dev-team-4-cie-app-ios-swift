//
//  LectureDetailViewModelMock.swift
//  CiE-iOSTests
//
//  Created by Nikita Hans on 10.06.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import Foundation

@testable import CiE_iOS

class LectureDetailViewModelMock: LectureDetailViewModelProtocol {
    var lecture: LectureProtocol { return injectedLecture }
    var title: String { return injectedTitle }
    var description: String { return injectedDescription }
    var contact: String { return injectedContact }
    
    var injectedLecture: LectureProtocol = LectureMock()
    var injectedTitle: String = ""
    var injectedDescription: String = ""
    var injectedContact: String = ""
    
    init(){}
    required init(containing: LectureProtocol) {}
}
