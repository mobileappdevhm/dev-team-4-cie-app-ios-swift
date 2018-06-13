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
    private var lectureIsAvailable: Bool {
        return containedLecture?.isSetUp ?? false
    }
    private var availableImage: UIImage? {
        return UIImage(
                    named: (lectureIsAvailable ? "courses_green" : "courses_yellow")
                )?.withRenderingMode(.alwaysTemplate)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        widthConstraint.constant = UIScreen.main.bounds.width
    }
    
    private func reloadStatusImage() {
        availableImg.image = availableImage
        availableImg.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let color = lectureIsAvailable ? UIColor.green : UIColor.orange
        availableImg.tintColor = color.withAlphaComponent(0.7)
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
        profLabel.text = lecture.professor.title ?? "Prof. test"
        roomLabel.text = lecture.lectureDates.first?.room.getNameRepresentation() ?? "R 2.010"
        fakultyLabel.text = lecture.connectedDepartments.isEmpty ? "FK01" : lecture.connectedDepartments[0].getString()
        setUpImageViews()
        return self
    }
}
