//
//  SigninViewController.swift
//  LocAloha
//
//  Created by Christopher Cabrera on 4/16/17.
//  Copyright © 2017 Kindred Dev. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class SigninViewController: UIViewController {
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
  
  @IBAction func signInWithEmail(_ sender: Any) {
    guard let email = emailTextField.text else {
      print("missing email")
      return
    }
    guard let password = passwordTextField.text else {
      print("missing password")
      return
    }
    
    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      print("\(user!.email!) created")
      self.performSegue(withIdentifier: "signInSegue", sender: nil)
    }
  }
  
  @IBAction func loginWithFacebook(_ sender: Any) {
    FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: self, handler: { (result,error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      if result!.isCancelled {
        print("cancelled")
        return
      }
      
      let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
      Auth.auth().signIn(with: credential) { (user, error) in
        if let error = error {
          print(error.localizedDescription)
          return
        }
        
        self.performSegue(withIdentifier: "signInSegue", sender: nil)
      }
    })
  }
}
