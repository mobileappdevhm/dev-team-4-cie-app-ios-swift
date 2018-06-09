//
//  LectureDetailPage01.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 07.06.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//
import Foundation

import UIKit

class LectureDetailPage01Controller: UIViewController{
    
    @IBOutlet weak var available: UIImageView!
    var availableImage: UIImage? { return UIImage(named: "courses_green")?.withRenderingMode(.alwaysTemplate)}
    var model: LectureDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = LectureDetailViewModel(containing:
            Lecture(
                withTitle: "Mobile Anwendungen",
                heldBy: Professor()
        ))
        model?.lecture.professor.email = "socher@hm.edu"
        setUpStyling()
    }
    
    private func setUpStyling() {
        available.image = availableImage
        available.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        available.tintColor = UIColor.green.withAlphaComponent(0.8)
    }
}
