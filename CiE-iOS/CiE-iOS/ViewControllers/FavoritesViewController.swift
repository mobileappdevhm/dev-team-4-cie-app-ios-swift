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
    
    private let submitButtonTitle = "Submit"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyling()
        setUpBinding()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Setup
    private func setUpStyling() {
        submitButton.setTitle(submitButtonTitle, for: .normal)
    }
    
    private func setUpBinding() {
        submitButton.addTarget(self, action: #selector(submitFavourites), for: .touchUpInside)
    }
    
    @objc
    private func submitFavourites() {
        print("submitted")
    }
}

