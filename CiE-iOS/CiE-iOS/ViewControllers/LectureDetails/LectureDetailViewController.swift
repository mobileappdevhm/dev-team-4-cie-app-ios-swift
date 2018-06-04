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
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var detailsNavigation: UINavigationItem!
    @IBOutlet weak var infoStack: UIStackView!
    private var detailModel: LectureDetailViewModelProtocol?
    var detailCompartments: [UIView]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailModel = LectureDetailViewModel(containing: Lecture(withTitle: "Test Title", heldBy: Professor()))
        setUpDetails()
        setUpBindings()
    }
    
    
    private func setUpBindings() {
        let close = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeView))
        close.tintColor = UIColor.red
        detailsNavigation.rightBarButtonItems = [close]    }
    
    @objc
    func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setUpDetails() {
        guard let detailModel = detailModel else { return }
        titleLabel.text = detailModel.title
        titleLabel.leadingAnchor.constraint(equalTo: detailBodyStack.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: detailBodyStack.trailingAnchor).isActive = true
        descriptionLabel.text = detailModel.description
        descriptionLabel.leadingAnchor.constraint(equalTo: detailBodyStack.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: detailBodyStack.trailingAnchor).isActive = true
        descriptionLabel.numberOfLines = 0
        detailCompartments = [titleLabel, descriptionLabel]
    }
    
}

