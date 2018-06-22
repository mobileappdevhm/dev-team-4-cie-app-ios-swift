//
//  LoginViewController.swift
//  CiE-iOS
//
//  Created by Jack Tan on 20/5/18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var gifImage: UIImageView!
    
    var loginSuccess: Bool = false {
        didSet{
            self.presentLoginWasSuccess(loginSuccess)
        }
    }
    
    private func presentLoginWasSuccess(_ success: Bool) {
        if success {
            self.performSegue(withIdentifier: "Login To Course View", sender: self)
        } else {
            self.present(
                AlertService.showInfo(titled: "Could not login!", message: "It seems as if we could not log you in."),
                animated: true,
                completion: nil
            )
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let password = passwordField.text, let email = usernameField.text else { return }
        UserStatsService.loginAs(User(withName: nil, andPassword: password, usingEmail: email), parent: self)
    }

    @IBAction func registerButtonPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://nine.wi.hm.edu/Account/Register")! as URL, options: [ :], completionHandler: nil)
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
        LectureCatalogService.getLectures(withUpdate: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = (textField == usernameField) ? passwordField.becomeFirstResponder() : passwordField.resignFirstResponder()
        return true
    }
}

