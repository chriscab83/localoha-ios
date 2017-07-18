//
//  WallTableViewController.swift
//  LocAloha
//
//  Created by Christopher Cabrera on 4/17/17.
//  Copyright © 2017 Kindred Dev. All rights reserved.
//

import UIKit

class MediaPostTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var postTimestampLabel: UILabel!
    @IBOutlet weak var postDistanceLabel: UILabel!
    @IBOutlet weak var postContentLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    var post: [String: AnyObject]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class WallTableViewController: UITableViewController {
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = FIRDatabase.database().reference(withPath:"posts")
        
        ref.observe(.value, with: { snapshot in
            var newItems: [Post] = []
            
            for item in snapshot.children {
                let post = Post(snapshot: item as! FIRDataSnapshot)
                newItems.append(post)
            }
            
            self.posts = newItems
            self.posts.sort(by: {$0.date as! Double > $1.date as! Double})
            self.tableView.reloadData()
        })
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if (posts.count == 0) {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No data available"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
            
            return 0
        }
        else {
            tableView.backgroundView  = nil;
            tableView.backgroundColor = UIColor.lightGray
            tableView.separatorStyle  = .none
            
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"MediaPostCell") as! MediaPostTableViewCell
        
        let post = posts[indexPath.row].toAnyObject() as! [String: AnyObject]
        
        // Configure the cell...
        let latitude = post["latitude"]!
        let longitude = post["longitude"]!
        let postText = post["postText"]!
        let timestamp = post["date"] as! Double
        let likes = post["likes"] as! Int
        
        
        let date = Date(timeIntervalSince1970: (timestamp / 1000) )
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EST") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMMM dd HH:mm a" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        
        cell.likeCount.text = (likes == 1) ? "\(likes) like" : "\(likes) likes"
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(WallTableViewController.likePost(_:)), for: .touchUpInside)

        cell.post = post
        cell.postTimestampLabel?.text = "\(strDate)"
        cell.postDistanceLabel?.text =  "\(latitude), \(longitude)"
        cell.postContentLabel?.text = "\(postText)"
        return cell
    }
    
    @IBAction func likePost(_ sender: UIButton) {
        let row = sender.tag
        
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        
        let cell = self.tableView.cellForRow(at: indexPath!)
        
        
        
        let post = posts[row]
        
        updateLikeCount(cell: cell as! MediaPostTableViewCell, count: post.likes + 1)
        
        post.ref?.updateChildValues([
            "likes": post.likes + 1
            ])
    }
    
    func updateLikeCount(cell: MediaPostTableViewCell, count: Int){
        cell.likeCount.text = "\(count)"
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            posts.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
}
