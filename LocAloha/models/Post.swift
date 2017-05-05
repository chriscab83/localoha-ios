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
  let location: CLLocation
  
  init(location: CLLocation, key: String = "") {
    self.key = key
    self.ref = nil
    self.location = location
  }
  
  init(latitude: Double, longitude: Double, key: String = "") {
    self.key = key
    self.ref = nil
    self.location = CLLocation(latitude: latitude, longitude: longitude)
  }
  
  init(snapshot: FIRDataSnapshot) {
    key = snapshot.key
    ref = snapshot.ref
    
    let val = snapshot.value as! [String: AnyObject]
    self.location = CLLocation(latitude: val["latitude"] as! Double, longitude: val["longitude"] as! Double)
  }
  
  func toAnyObject() -> Any {
    return [
      "latitude":location.coordinate.latitude,
      "longitude":location.coordinate.longitude
    ]
  }
  
}
