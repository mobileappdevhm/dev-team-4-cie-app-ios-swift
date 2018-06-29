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
        
        //listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    //stop listening for keyboards event
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = (textField == usernameField) ? passwordField.becomeFirstResponder() : passwordField.resignFirstResponder()
        return true
    }
    
    //move text field in response to keyboard
    @objc func keyboardWillChange(notification: Notification){
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == Notification.Name.UIKeyboardWillShow ||
            notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    //SE
                    view.frame.origin.y = -keyboardRect.height + 70
                case 1334:
                    //iPhone 8
                    view.frame.origin.y = -keyboardRect.height + 150
                case 1920, 2208:
                    //iPhone 8+
                    view.frame.origin.y = -keyboardRect.height + 200
                case 2436:
                    //X
                    view.frame.origin.y = -keyboardRect.height + 300
                default:
                    return
                }
            }
        } else {
                 view.frame.origin.y = 0
            }
        }
        
    }
    
    
    


