//
//  RegistrationViewController.swift
//  RocketChat
//
//  Created by Aurelio Le Clarke on 09.02.2022.
//


import UIKit
import Firebase

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func RegistratePressed(_ sender: UIButton) {
         if let email = emailTextField.text, let password = passwordTextField.text {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e  = error {
                print(e.localizedDescription)
            }else {
                self.performSegue(withIdentifier: K.registerSegue, sender: self)
            }
        }
    }
    }



}
