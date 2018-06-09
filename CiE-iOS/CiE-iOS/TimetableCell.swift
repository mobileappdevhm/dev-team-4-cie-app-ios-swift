//
//  TimetableCell.swift
//  CiE-iOS
//
//  Created by Jack Tan on 7/6/18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class TimetableCell: UITableViewCell {

    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var campusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
