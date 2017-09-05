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
  let ref: DatabaseReference?
  let date: Any
  let location: CLLocation
  let postText: String
  let likes: Int
  let likers: [String]
  
    init(location: CLLocation, text: String = "", key: String = "") {
    self.key = key
    self.ref = nil
    self.location = location
    self.postText = text
    self.date = ""
    self.likes = 0
    self.likers = []
    }
  
    init(latitude: Double, longitude: Double, date: Any, likes: Int = 0, text: String, key: String = "", likers: [String] = []) {
    self.key = key
    self.ref = nil
    self.date = date
    self.postText = text
    self.likes = likes
    self.location = CLLocation(latitude: latitude, longitude: longitude)
    self.likers = likers
  }
  
  init(snapshot: DataSnapshot) {
    key = snapshot.key
    ref = snapshot.ref
    
    let val = snapshot.value as! [String: AnyObject]
    self.location = CLLocation(latitude: val["latitude"] as! Double, longitude: val["longitude"] as! Double)
    self.postText = val["postText"] as! String
    self.date = val["date"] as Any
    self.likes = (val["likes"] != nil) ? val["likes"] as! Int : 0
    self.likers = (val["likers"] != nil) ? val["likers"] as! [String] : []
  }
  
  func toAnyObject() -> Any {
    return [
      "date": date,
      "latitude":location.coordinate.latitude,
      "longitude":location.coordinate.longitude,
      "postText":postText,
      "likes":likers.count,
      "likers": likers
    ]
  }
  
}
