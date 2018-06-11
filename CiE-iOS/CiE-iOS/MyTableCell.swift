//
//  MyTableCell.swift
//  CiE-iOS
//
//  Created by Snezana Eckl on 11.06.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

protocol MyTableCellDelegate {
    func MyTableCellDidTapDetails(_ sender: MyTableCell)
    func MyTableCellDidTapFavorites(_ sender: MyTableCell)
}

class MyTableCell: UITableViewCell {


    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!
    
    @IBOutlet weak var facultyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var delegate: MyTableCellDelegate?
    
    @IBAction func detailsTapped(_ sender: UIButton){
        delegate?.MyTableCellDidTapDetails(self)
    }
    
    @IBAction func favoritesTapped(_ sender: UIButton){
        delegate?.MyTableCellDidTapFavorites(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
