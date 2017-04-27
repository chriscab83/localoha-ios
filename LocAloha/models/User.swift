//
//  User.swift
//  LocAloha
//
//  Created by Christopher Cabrera on 4/26/17.
//  Copyright © 2017 Kindred Dev. All rights reserved.
//

import Foundation

struct User {
  let uid: String
  let email: String
  
  init(authData: FIRUser) {
    uid = authData.uid
    email = authData.email!
  }
  
  init(uid: String, email: String) {
    self.uid = uid
    self.email = email
  }
}
