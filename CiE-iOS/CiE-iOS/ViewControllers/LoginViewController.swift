//
//  LoginViewController.swift
//  CiE-iOS
//
//  Created by Jack Tan on 20/5/18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var gifImage: UIImageView!
    
    @IBAction func loginButtonPressed(_ sender: Any) {
       self.performSegue(withIdentifier: "Login To Course View", sender: self)
    }

    private func setupstyling(){
        loginButton.setTitle("Log in", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupstyling()
        usernameField.delegate = self
        passwordField.delegate = self
        gifImage.loadGif(name: "LoginRedCube")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = (textField == usernameField) ? passwordField.becomeFirstResponder() : passwordField.resignFirstResponder()
        return true
    }
}

