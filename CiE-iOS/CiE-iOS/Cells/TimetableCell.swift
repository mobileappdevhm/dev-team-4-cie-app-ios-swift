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
    
    private var containedTimeTable: Timetable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @discardableResult
    func map(to timetable: Timetable) -> TimetableCell {
        containedTimeTable = timetable
        guard let courseAppointment = containedTimeTable else { return self }
        titleLabel.text = courseAppointment.course
        roomLabel.text = "R.021"
        fakultyLabel.text = "FK07"
        profLabel.text = "Prof. Socher"
        timeFrameLabel.text = courseAppointment.time
        return self
    }
}
