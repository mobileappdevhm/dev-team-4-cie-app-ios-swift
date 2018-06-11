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
    
    @IBOutlet weak var favourite: UIImageView!
    @IBOutlet weak var email: UIImageView!
    private let emptyFavourites = UIImage(named: "favourite_border")?.withRenderingMode(.alwaysTemplate)
    private let filledFavourites = UIImage(named: "favourite")?.withRenderingMode(.alwaysTemplate)
    private var addFavouriteImage: UIImage? {
        return (addFavouriteDoesAdd ?? true ? emptyFavourites : filledFavourites)
    }
    private let addContactImage: UIImage? = UIImage(named: "settings_email")?.withRenderingMode(.alwaysTemplate)
    private var addFavouriteDoesAdd:Bool?
    var model: LectureDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let prof = Professor()
        prof.email = "socher@hm.edu"
        prof.name = "Socher"
        model = LectureDetailViewModel(containing:
            Lecture(
                withTitle: "Mobile Anwendungen",
                heldBy: prof
            ))
        model?.lecture.setECTS(to: 2)
        addFavouriteDoesAdd = !(model?.isFavourite() ?? false)
        setUpStyling()
        setUpBinding()
    }
    
    private func setUpStyling() {
        favourite.image = addFavouriteImage
        favourite.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        favourite.tintColor = UIColor.red.withAlphaComponent(0.7)
        
        email.image = addContactImage
        email.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        email.tintColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    private func setUpBinding() {
        let favouriteTap = UITapGestureRecognizer(target: self, action: #selector(addToFavourite(tapGestureRecognizer:)))
        let emailTap = UITapGestureRecognizer(target: self, action: #selector(sendEmailAction(tapGestureRecognizer:)))
        email.isUserInteractionEnabled = true
        favourite.isUserInteractionEnabled = true
        favourite.addGestureRecognizer(favouriteTap)
        email.addGestureRecognizer(emailTap)
    }
    
    @objc
    func addToFavourite(tapGestureRecognizer recon: UITapGestureRecognizer) {
        guard let lecture = model?.lecture, let adding = addFavouriteDoesAdd else { return }
        moveToFavourites(lecture as? Lecture)
        addFavouriteDoesAdd = !adding
        favourite.image = addFavouriteImage
    }
    
    @objc
    func sendEmailAction(tapGestureRecognizer recon: UITapGestureRecognizer) {
        guard let email = model?.lecture.professor.email, let prof = model?.lecture.professor.name else { return }
        openEmail(withTarget: email, adressing: prof )
    }
    
    func showEmailAlert(wantsToSendTo email: String, named prof: String) {
        let myAlertController = AlertService.showConfirmAlert(
                titled: "Send an email?",
                withSubtitle: "Do you want to contact the professor via email?",
                onCancel: { UIAlertAction -> Void in
                
                },
                onConfirm: { UIAlertAction -> Void in
                    if let url = URL(string: "mailto:\(email)?subject=Dear%20Prof.%20\(prof)%20%20-%20%20CIEApp"){
                        UIApplication.shared.open(url)
                    }
                }
            )
        self.present(myAlertController, animated: true, completion: nil)
    }

    
    private func moveToFavourites(_ lecture: Lecture?) {
        guard let lecture = lecture, let adding = addFavouriteDoesAdd else { return }
        adding ? FavouriteService.add(lecture) : FavouriteService.remove(lecture)
    }
    
    private func openEmail(withTarget email: String, adressing name: String) {
        showEmailAlert(wantsToSendTo: email, named: name)
    }
    
    private func style(button btn: UIButton) {
        btn.backgroundColor = UIColor.white.withAlphaComponent(1)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
    }
}
