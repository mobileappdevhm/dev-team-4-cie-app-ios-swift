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
    
    @IBOutlet weak var validCie: UILabel!
    @IBOutlet weak var ectsScore: UILabel!
    @IBOutlet weak var available: UIImageView!
    var availabilityStatus: LectureAvailability {
        guard let model = model else { return .unavailable }
        return model.lecture.available
    }
    var availableImage: UIImage? {
        return availabilityStatus.getImage()
    }
    var model: LectureDetailViewModelProtocol? {
        didSet{
            setUpStyling()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyling()
    }
    
    private func setUpStyling() {
        available.image = availableImage
        available.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        available.tintColor = availabilityStatus.getColor()
        guard let model = model else { return }
//        if let ects = model.lecture.ects {
//            ectsScore.text = String(ects)
//        }
        if let lectureDate = model.lecture.lectureDates.first {
            ectsScore.text = lectureDate.getTimeBoxString()
        }
        if let isCiE = model.lecture.isCiE {
            validCie.text = isCiE ? "Yes" : "No"
        }
    }
}
