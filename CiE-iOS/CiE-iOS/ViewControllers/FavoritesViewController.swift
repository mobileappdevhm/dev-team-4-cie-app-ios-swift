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
    
    private var model: FavoritesViewModelProtocol?
    private let warningText = "Time conflicts detected!"
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
    }
    
    private func setUpBinding() {
        submitButton.addTarget(self, action: #selector(showAlertIfConflicting), for: UIControlEvents.touchUpInside)
        detailsSwitch.addTarget(self, action: #selector(switchChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    @objc
    func switchChanged(sender: UISwitch!) {
        UIView.animate(withDuration: 0.2) {
            self.detailsStackView.isHidden = !sender.isOn
            self.warningLabel.isHidden = !sender.isOn
        }
    }
    
    @objc
    func showAlertIfConflicting() {
        guard let needsAlert = model?.hasConflicts, let conflict = model?.conflictForAlert else { return }
        guard needsAlert else { return }
        let myAlertController = AlertService.showConfirmAlert(
            titled: "Conflict!",
            withSubtitle: "\(conflict.alertDescription()) Are you sure you want to submit your selection?",
            onCancel: { UIAlertAction -> Void in
                print("aborted")
            },
            onConfirm: { UIAlertAction -> Void in
                print("confirmed")
            }
        )
        self.present(myAlertController, animated: true, completion: nil)
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

