//
//  FavoritesViewController.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 12.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var alertHeight: NSLayoutConstraint!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var detailsSwitch: UISwitch!
    @IBOutlet weak var detailStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var detailsSeparatorWidth: NSLayoutConstraint!
    
    private let warningText = "Time conflicts detected!"
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    private func setUpBinding() {
        submitButton.addTarget(self, action: #selector(showAlert), for: UIControlEvents.touchUpInside)
        detailsSwitch.addTarget(self, action: #selector(switchChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    @objc
    func switchChanged(sender: UISwitch!) {
        UIView.animate(withDuration: 0.8){
            self.detailStackViewHeight.constant = sender.isOn ? CGFloat(100) : CGFloat(0)
            self.detailsSeparatorWidth.constant = sender.isOn ? CGFloat(1) : CGFloat(0)
        }
    }
    
    @objc
    func showAlert() {
        warningLabel.text = warningText
        alertHeight.constant = CGFloat(50)
    }
}

