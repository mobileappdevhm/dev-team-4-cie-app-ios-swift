//
//  FavoritesViewController.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 12.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var submitStackView: UIStackView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var detailsSwitch: UISwitch!
    @IBOutlet weak var detailsStackView: UIStackView!
    @IBOutlet weak var ectsProgress: UIProgressView!
    @IBOutlet weak var ectsLabel: UILabel!
    @IBOutlet weak var cieLabel: UILabel!
    @IBOutlet weak var cieProgress: UIProgressView!
    
    private var model: FavoritesViewModelProtocol?
    private let warningText = "Time conflicts detected!"
    private let amountNeededForCertificate:Int = 7
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = FavoritesViewModel()
        setUpStyling()
        setUpBinding()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpStyling() {
        submitButton.backgroundColor = UIColor.red.withAlphaComponent(0.8)
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.lightGray.cgColor
        
        warningLabel.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        
        detailsSwitch.setOn(false, animated: false)
        detailsStackView.isHidden = true
        
        warningLabel.text = warningText
        warningLabel.isHidden = true
        
        pinBackground(backgroundView, to: submitStackView)
        updateUserStats()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        model?.update()
        setUpStyling()
    }
    
    private func setUpBinding() {
        submitButton.addTarget(self, action: #selector(addFavourtiesToSemesterWithAlert), for: UIControlEvents.touchUpInside)
        detailsSwitch.addTarget(self, action: #selector(switchChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    func updateUserStats() {
        guard let model = model else { return }
        let allECTS = model.allECTS
        ectsLabel.text = "Your ECTS: \(allECTS) out of 10"
        ectsProgress.setProgress(Float(allECTS)/10, animated: (allECTS != 0))
        
        let allCiE = model.allCiE
        cieLabel.text = "Your CiE : \(allCiE) out of \(amountNeededForCertificate)"
        cieProgress.setProgress(Float(allCiE)/Float(amountNeededForCertificate), animated: (allCiE != 0))
        
    }
    
    @objc
    func switchChanged(sender: UISwitch!) {
        UIView.animate(withDuration: 0.2) {
            self.detailsStackView.isHidden = !sender.isOn
            self.warningLabel.isHidden = !sender.isOn
            if sender.isOn { self.updateUserStats() }
        }
    }
    
    @objc
    func confirmTapped() {
        addFavourtiesToSemesterWithAlert()
    }
    
    func showInfo(titled title: String, saying message: String) {
        let myAlertController = AlertService.showInfo(titled: title, message: message)
        self.present(myAlertController, animated: true, completion: nil)
    }
    
    @objc func addFavourtiesToSemesterWithAlert() {
        guard let favourites = model?.favourites, !favourites.isEmpty else {
            showInfo(titled: "Nothing here.", saying: "You need to add some favourites first.")
            return
        }
        guard let needsAlert = model?.hasConflicts else { return }
        let submit: (UIAlertAction) -> Void = { UIAlertAction -> Void in
            self.confirmedSubmit()
        }
        let cancel: (UIAlertAction) -> Void = { UIAlertAction -> Void in
            self.showInfo(titled: "Aborted!", saying: "You did NOT submit your favourites.")
        }
        if needsAlert {
            let conflictDescription = model?.conflictForAlert?.alertDescription() ?? ConflictIndicator.generalDescription(.other)
            let myAlertController = AlertService.showConfirmAlert(
                titled: "Conflict!",
                withSubtitle: "\(conflictDescription) Are you sure you want to submit your selection?",
                onCancel: cancel,
                onConfirm: submit
            )
            self.present(myAlertController, animated: true, completion: nil)
        } else {
            let myAlertController = AlertService.showConfirmAlert(
                titled: "Confirm!",
                withSubtitle: "Please confirm that you want to enroll in these courses.",
                onCancel: cancel,
                onConfirm: submit
            )
            self.present(myAlertController, animated: true, completion: nil)
        }
    }
    
    func confirmedSubmit() {
        guard let model = self.model else { return }
        model.addFavourites()
        model.clearFavourites()
        model.update()
        self.updateUserStats()
    }
    
    private func pinBackground(_ view: UIView, to stackView: UIStackView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(view, at: 0)
        pin(view: stackView, to: view)
    }
    
    private func pin(view: UIView,to source: UIView) {
        NSLayoutConstraint.activate([
            source.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            source.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            source.topAnchor.constraint(equalTo: view.topAnchor),
            source.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

