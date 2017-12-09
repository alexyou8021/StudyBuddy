//
//  EventFriendsTableViewController.swift
//  StudyBuddy
//
//  Created by Vikram Idury on 10/31/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class EventFriendsTableViewController: UITableViewController {
    
    var friends : [String:Bool] = [:]
    var friendIds: [String] = []
    var numFriends: Int = 0
    var ref: DatabaseReference!
    var addEventVC: AddEventViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let em = user?.email
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        
        self.ref.child("users").child(em2).child("friends").observe(.value, with: { snapshot in
            if snapshot.exists() {
                self.numFriends = Int(snapshot.childrenCount)
                self.friends = snapshot.value as! [String:Bool]
                self.friendIds = Array(self.friends.keys)
                self.tableView.reloadData()
            } else {
                self.numFriends = 0
                self.friends = [:]
                self.friendIds = []
                self.tableView.reloadData()
            }
        })
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendIds.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventFriendCell", for: indexPath)
        let friend = friendIds[indexPath.row]
        var substrings = friend.split(separator: "@")
        let ending = substrings[1].replacingOccurrences(of: "dot", with: ".")
        cell.textLabel?.text = substrings[0] + "@" + ending
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
            addEventVC.selectedFriends.remove(friendIds[indexPath.row])
        } else {
            cell.accessoryType = .checkmark
            addEventVC.selectedFriends.insert(friendIds[indexPath.row])
        }
    }
 


}
