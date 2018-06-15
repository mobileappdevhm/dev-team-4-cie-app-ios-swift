//
//  LoginViewController.swift
//  CiE-iOS
//
//  Created by Jack Tan on 20/5/18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    

//    @IBOutlet weak var logoutButton: UIButton!

    @IBAction func loginButtonPressed(_ sender: Any) {
       self.performSegue(withIdentifier: "Login To Course View", sender: self)
    }
    
    
//    private func setupstyling(){
//        logoutButton.setTitle("Log in", for: .normal)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        setupstyling()
    }
 
    
}

