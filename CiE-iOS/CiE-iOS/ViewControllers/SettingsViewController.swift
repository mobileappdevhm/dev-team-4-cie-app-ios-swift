//
//  SettingsViewController.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 12.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var logOut: UIButton!
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
         self.performSegue(withIdentifier: "Login View Controller", sender: self)
    }
    
    private func setupstyling(){
        logOut.setTitle("Heyho", for: .normal)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupstyling()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

