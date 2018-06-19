//
//  FavouriteLectureCell.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 13.06.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class FavouriteLectureCell: UITableViewCell {
    @IBOutlet weak var availableImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var fakultyLabel: UILabel!
    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    private var containedLecture: Lecture?
    private var lectureAvailableState: LectureAvailability {
        return containedLecture?.available ?? .unavailable
    }
    private var availableImage: UIImage? {
        return lectureAvailableState.getImage()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        widthConstraint.constant = UIScreen.main.bounds.width
    }
    
    private func reloadStatusImage() {
        availableImg.image = availableImage
        availableImg.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        availableImg.tintColor = lectureAvailableState.getColor()
    }
    
    private func setUpImageViews() {
        reloadStatusImage()
    }
    
    @objc
    func removeFav(tapGestureRecognizer recon: UITapGestureRecognizer) {
        guard let lecture = containedLecture else { return }
        FavouriteService.remove(lecture)
        isHidden = true
    }
    
    @discardableResult
    func map(to lecture: Lecture) -> FavouriteLectureCell {
        containedLecture = lecture
        guard let lecture = containedLecture else { return self }
        reloadStatusImage()
        titleLabel.text = lecture.title
        profLabel.text = lecture.professor.name
        roomLabel.text = lecture.lectureDates.first?.room.getNameRepresentation() ?? "Unknown"
        fakultyLabel.text = lecture.connectedDepartments.isEmpty ? Department.Undefined.getString() : lecture.connectedDepartments[0].getString()
        setUpImageViews()
        return self
    }
}
