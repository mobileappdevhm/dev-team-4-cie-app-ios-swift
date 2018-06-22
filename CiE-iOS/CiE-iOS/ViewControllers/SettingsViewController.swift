//
//  SettingsViewController.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 12.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var emailImageView: UIImageView!
    
    @IBOutlet weak var statsButton: UIButton!
    @IBOutlet weak var statsStack: UIStackView!
    @IBOutlet weak var currentECTS: UILabel!
    @IBOutlet weak var currentECTSProgress: UIProgressView!
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var settingStack: UIStackView!
    @IBOutlet weak var currentCiE: UILabel!
    @IBOutlet weak var cieCertificateInfo: UILabel!
    @IBOutlet weak var currentCiEProgress: UIProgressView!
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    private var model: SettingsViewModel?
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let contactImage: UIImage? = UIImage(named: "settings_email")?.withRenderingMode(.alwaysTemplate)
    private let userImage: UIImage? = UIImage(named: "user")?.withRenderingMode(.alwaysTemplate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = UserStatsService.user
        model = SettingsViewModel(withUser: user!)
        setUpStyling()
        setUpBinding()
    }
    
    private func setUpStyling() {
        userIconImageView.image = userImage
        userIconImageView.tintColor = UIColor.black.withAlphaComponent(0.8)
        userIconImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        emailImageView.image = contactImage
        emailImageView.tintColor = UIColor.red.withAlphaComponent(0.6)
        emailImageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        statsStack.isHidden = true
        settingStack.isHidden = true
        pinBackground(backgroundView, to: statsStack)
        pinBackground(backgroundView, to: settingStack)
        style(button: logoutButton)
        
        guard let user = model?.user else { return }
        userName.text = user.name ?? "Snezana"
        userEmail.text = user.email
        updateCiE()
        cieCertificateInfo.text = "If you have all 7, you get the CiE Certificate !"
        updateECTS()
    }
    
    private func updateCiE() {
        let cieScore = UserStatsService.currentCiE()
        currentCiE.text = "You currently have \(cieScore) out of 7"
        currentCiEProgress.progress = Float(cieScore)/7
    }
    
    private func updateECTS() {
        let ectsScore = UserStatsService.currentECTS()
        currentECTS.text = "You currently have \(ectsScore) out of 200"
        currentECTSProgress.progress = Float(ectsScore)/200
    }
    
    private func setUpBinding() {
        statsButton.addTarget(self, action: #selector(statsTapped), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        
    }
    
    private func adjustContentSize() {
        var contentRect = CGRect.zero
        for view in mainScrollView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        mainScrollView.contentSize = contentRect.size
    }
    
    @objc
    func statsTapped() {
        UIView.animate(withDuration: 0.3) {
            self.adjustContentSize()
            self.statsStack.isHidden = !self.statsStack.isHidden
        }
    }
    
    @objc
    func settingsTapped() {
        UIView.animate(withDuration: 0.3) {
            self.adjustContentSize()
            self.settingStack.isHidden = !self.settingStack.isHidden
        }
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
    
    private func style(button btn: UIButton) {
        btn.backgroundColor = UIColor.red.withAlphaComponent(0.6)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
    }
}

