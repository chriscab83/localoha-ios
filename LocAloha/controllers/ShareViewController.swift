//
//  ShareViewController.swift
//  LocAloha
//
//  Created by Christopher Cabrera on 4/17/17.
//  Copyright © 2017 Kindred Dev. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ShareButton(_ sender: Any) {
        
        let text = PostText.text
        
        // TODO: Get geo data
        let latitude: Double = 11.234
        let longitude: Double = 15.35
        
        // 2
        let post = Post(latitude: latitude,longitude: longitude)
        // 3
        let postsRef = FIRDatabase.database().reference(withPath: "posts")
        let childRef = postsRef.child("post") // TODO: make this a unique id instead
        
        // 4
        childRef.setValue(post.toAnyObject())
    }

    @IBOutlet weak var PostText: UITextView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
