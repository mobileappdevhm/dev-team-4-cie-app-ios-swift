//
//  LectureDetailPage03Controller.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 30.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import Foundation

import UIKit

class LectureDetailPage03Controller: UIViewController{
    
    
    @IBOutlet weak var addFavourite: UIButton!
    @IBOutlet weak var sendEmail: UIButton!
    private let emptyFavourties = UIImage(named: "favourite_border")
    private let filledFavourites = UIImage(named: "favourite")
    private var addFavouriteImage: UIImage {
        return (addFavouriteDoesAdd ? emptyFavourties : filledFavourites)!
    }
    private var addFavouriteDoesAdd = true
    var model: LectureDetailViewModelProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = LectureDetailViewModel(containing:
            Lecture(
                withTitle: "Mobile Anwendungen",
                heldBy: Professor()
            ))
        model?.lecture.professor.email = "socher@hm.edu"
        setUpStyling()
        setUpBinding()
    }
    
    private func setUpStyling() {
        style(button: addFavourite)
        style(button: sendEmail)
    }
    
    private func setUpBinding() {
        sendEmail.addTarget(self, action: #selector(sendEmailAction), for: .touchUpInside)
        addFavourite.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
    }
    
    @objc
    func addToFavourite() {
        guard let id = model?.lecture.id else { return }
        moveToFavourites(usingID: id)
        addFavouriteDoesAdd = !addFavouriteDoesAdd
        addFavourite.setImage(addFavouriteImage, for: .normal)
    }
    
    @objc
    func sendEmailAction() {
        guard let email = model?.lecture.professor.email else { return }
        openEmail(withTarget: email)
    }
    
    private func moveToFavourites(usingID id: UUID) {
        print("add Lecture with id:\(id)")
    }
    
    private func openEmail(withTarget email: String) {
        if let url = URL(string: "mailto:\(email)?subject=Contact%20from%20CiE-App"){
            UIApplication.shared.open(url)
        }
        print("open Email for \(email)")
    }
    
    private func style(button btn: UIButton) {
        btn.backgroundColor = UIColor.white.withAlphaComponent(1)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
    }
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
