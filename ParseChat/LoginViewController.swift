//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Hoang on 2/21/18.
//  Copyright © 2018 Hoang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet var signupButton: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func signupPressed(_ sender: UIButton) {
        showAlert()
        
        let newUser = PFUser()
        newUser.username = usernameField.text!
        newUser.password = passwordField.text!
        
        newUser.signUpInBackground { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // TODO move to chat
            }
        }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        showAlert()
        
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                // TODO move to chat
            }
        }
    }
    
    func showAlert() {
        if let text = usernameField.text {
            if text.isEmpty {
                let ac = UIAlertController(title: "Missing Info", message: "Fill everything out", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(ac, animated: true, completion: nil)
            }
        }
        
        if let text = passwordField.text {
            if text.isEmpty {
                let ac = UIAlertController(title: "Missing Info", message: "Fill everything out", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(ac, animated: true, completion: nil)
            }
        }
    }
    
}
