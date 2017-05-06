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

class WallTableViewController: UITableViewController {
    
    var posts: [Post] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let ref = FIRDatabase.database().reference(withPath: "posts")

        ref.observe(.value, with: { snapshot in
            // 2
            var newItems: [Post] = []
            
            // 3
            for item in snapshot.children {
                // 4
                let post = Post(snapshot: item as! FIRDataSnapshot)
                newItems.append(post)
            }
            
            // 5
            self.posts = newItems
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let sections = 1
        
        //        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        //        noDataLabel.text          = "No data available"
        //        noDataLabel.textColor     = UIColor.black
        //        noDataLabel.textAlignment = .center
        //        tableView.backgroundView  = noDataLabel
        //        tableView.separatorStyle  = .none
        tableView.backgroundColor = UIColor.lightGray
        tableView.separatorStyle  = .none
        
        return sections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.posts.count
    }
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    let colors = [UIColor.blue, UIColor.yellow, UIColor.magenta, UIColor.red, UIColor.brown]
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"PostCell") as! WallViewTableCell
        
        let post = posts[indexPath.row].toAnyObject() as! [String: AnyObject]
        print(post["latitude"] )
        // Configure the cell...
        
        let latitude = post["latitude"]!
        let longitude = post["longitude"]!
        
        cell.location?.text =  "\(latitude), \(longitude)"
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
