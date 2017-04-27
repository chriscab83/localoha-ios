//
//  SignupViewController.swift
//  LocAloha
//
//  Created by Christopher Cabrera on 4/16/17.
//  Copyright © 2017 Kindred Dev. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUp(_ sender: Any) {
        guard let email = emailTextField.text else {
            print("missing email")
            return
        }
        guard let password = passwordTextField.text else {
            print("missing password")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print("\(user!.email!) created")
            self.performSegue(withIdentifier: "signUpSegue", sender: nil)
        }
    }
}
