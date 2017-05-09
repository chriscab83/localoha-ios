//
//  WallTableViewController.swift
//  LocAloha
//
//  Created by Christopher Cabrera on 4/17/17.
//  Copyright © 2017 Kindred Dev. All rights reserved.
//

import UIKit

class WallViewTableCell: UITableViewCell {
  @IBOutlet weak var location: UILabel!
}

class MediaPostTableViewCell: UITableViewCell {
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var postTimestampLabel: UILabel!
  @IBOutlet weak var postDistanceLabel: UILabel!
  @IBOutlet weak var postContentLabel: UILabel!
  @IBOutlet weak var postImageView: UIImageView!
  
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
    
    let ref = FIRDatabase.database().reference(withPath: "posts")
    
    ref.observe(.value, with: { snapshot in
      var newItems: [Post] = []
      
      for item in snapshot.children {
        let post = Post(snapshot: item as! FIRDataSnapshot)
        newItems.append(post)
      }
      
      self.posts = newItems
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
    
    cell.postDistanceLabel?.text =  "\(latitude), \(longitude)"
    cell.postContentLabel?.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eius adipisci, sed libero. Iste asperiores suscipit, consequatur debitis animi impedit numquam facilis iusto porro labore dolorem, maxime magni incidunt. Delectus, est!"
    
    return cell
  }
}
