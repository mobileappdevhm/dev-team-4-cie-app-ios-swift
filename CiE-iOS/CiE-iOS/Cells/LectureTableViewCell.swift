//
//  LectureTableViewCell.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 12.06.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class LectureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fakultyLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var professorLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    
    private var willAddFav: Bool {
        guard let lecture = containedLecture else { return true }
        return !FavouriteService.currentFavourites().contains(lecture)
    }
    var containedLecture: Lecture?
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.backgroundColor = UIColor.clear.cgColor
        setUpFavImageBinding()
    }
    
    @discardableResult
    func map(to lecture: Lecture) -> LectureTableViewCell {
        containedLecture = lecture
        titleLabel.text = lecture.title
        fakultyLabel.text = lecture.connectedDepartments.isEmpty ?
            "Unknown Department" : lecture.connectedDepartments[0].getString()
        roomLabel.text = lecture.lectureDates.first?.room.getNameRepresentation() ?? "R 1.010"
        professorLabel.text = lecture.professor.name
        setFavImage()
        return self
    }
    
    private func setFavImage() {
        let imageName = willAddFav ? "favourite_border" : "favourite"
        favouriteImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        favouriteImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        favouriteImageView.tintColor = UIColor.red.withAlphaComponent(0.7)
    }
    
    private func setUpFavImageBinding() {
        let favouriteTap = UITapGestureRecognizer(target: self, action: #selector(addToFavourite(tapGestureRecognizer:)))
        favouriteImageView.isUserInteractionEnabled = true
        favouriteImageView.addGestureRecognizer(favouriteTap)
        
    }
    
    @objc
    func addToFavourite(tapGestureRecognizer recon: UITapGestureRecognizer) {
        guard let lecture = containedLecture else { return }
        willAddFav ? FavouriteService.add(lecture) : FavouriteService.remove(lecture)
        setFavImage()
    }
}
