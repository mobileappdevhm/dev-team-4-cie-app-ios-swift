//
//  TimetableCell.swift
//  CiE-iOS
//
//  Created by Jack Tan on 7/6/18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class TimetableCell: UITableViewCell {
    
    @IBOutlet weak var fakultyLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var profLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeFrameLabel: UILabel!
    
    private var containedLecture: Lecture?
    private var createdForDate: LectureDate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @discardableResult
    func map(to lectureTuple: (Lecture,LectureDate)) -> TimetableCell {
        containedLecture = lectureTuple.0
        createdForDate = lectureTuple.1
        guard let lecture = containedLecture else { return self }
        titleLabel.text = lecture.title
        fakultyLabel.text = lecture.connectedDepartments.first?.getString() ?? "Unknown Department"
        profLabel.text = lecture.professor.name
        
        guard let date = createdForDate else { return self }
        roomLabel.text = date.room.getNameRepresentation()
        timeFrameLabel.text = date.getTimeBoxString()
        return self
    }
}
