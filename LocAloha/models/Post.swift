//
//  Post.swift
//  LocAloha
//
//  Created by Christopher Cabrera on 4/26/17.
//  Copyright © 2017 Kindred Dev. All rights reserved.
//

import Foundation
import CoreLocation

struct Post {
  
  let key: String
  let ref: FIRDatabaseReference?
  let date: Any
  let location: CLLocation
  let postText: String
  
    init(location: CLLocation, text: String = "", key: String = "") {
    self.key = key
    self.ref = nil
    self.location = location
    self.postText = text
    self.date = 0  }
  
    init(latitude: Double, longitude: Double, date: Any, text: String, key: String = "") {
    self.key = key
    self.ref = nil
    self.date = date
    self.postText = text
    self.location = CLLocation(latitude: latitude, longitude: longitude)
  }
  
  init(snapshot: FIRDataSnapshot) {
    key = snapshot.key
    ref = snapshot.ref
    
    let val = snapshot.value as! [String: AnyObject]
    self.location = CLLocation(latitude: val["latitude"] as! Double, longitude: val["longitude"] as! Double)
    self.postText = val["postText"] as! String
    self.date = val["date"] as Any
  }
  
  func toAnyObject() -> Any {
    return [
      "date": date,
      "latitude":location.coordinate.latitude,
      "longitude":location.coordinate.longitude,
      "postText":postText
    ]
  }
  
}
