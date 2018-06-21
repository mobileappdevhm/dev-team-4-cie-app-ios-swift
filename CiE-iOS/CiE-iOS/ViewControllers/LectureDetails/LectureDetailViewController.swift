//
//  LectureDetailViewController.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 28.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class LectureDetailViewController: UIViewController{
    
    @IBOutlet weak var detailBodyStack: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var infoStack: UIStackView!
    var detailModel: LectureDetailViewModelProtocol?
    var detailCompartments: [UIView]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetails()
        guard let detailModel = detailModel else { return }
        (childViewControllers[0] as! LectureDetailPageViewController).model = detailModel
    }
    
    func updatePageIndicator(to index: Int) {
        pageLabel.text = "\(index + 1) of 3"
    }
    
    private func setUpDetails() {
        guard let detailModel = detailModel else { return }
        titleLabel.text = detailModel.title
        descriptionLabel.text = detailModel.description
        descriptionLabel.numberOfLines = 0
        detailCompartments = [titleLabel, descriptionLabel]
    }
    
    func setLecture(to lecture: Lecture) {
        detailModel = LectureDetailViewModel(containing: lecture)
    }
    
}

