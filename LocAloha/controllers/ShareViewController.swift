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
        let date = ServerValue.timestamp()
        // 2
        let post = Post(latitude: latitude,longitude: longitude, date: date, text: text!)
        // 3
        let postsRef = Database.database().reference(withPath: "posts")
        let postRef = postsRef.childByAutoId()
        
        postRef.setValue(post.toAnyObject())
        
        let postId = postRef.key
        print("new post id: \(postId)")
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
