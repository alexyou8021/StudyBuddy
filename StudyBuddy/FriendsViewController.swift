//
//  FriendsViewController.swift
//  StudyBuddy
//
//  Created by Mitchell Minkoff on 10/28/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var friendsTable: UITableView!
    
    var main_friends:[String:Bool] = [:]
    var keys:[String] = []
    var numFriends = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsTable.delegate = self
        friendsTable.dataSource = self
        ref = Database.database().reference()
        
        let user = Auth.auth().currentUser
        let em = user?.email
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        print(em2)
        
        self.ref.child("users").child(em2).child("friends").observe(.value, with: { snapshot in
            if snapshot.exists() {
                self.numFriends = Int(snapshot.childrenCount)
                self.main_friends = snapshot.value as! [String:Bool]
                self.keys = Array(self.main_friends.keys)
                self.friendsTable.reloadData()
            } else {
                self.main_friends = [:]
                self.keys = []
                self.friendsTable.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }
    
    func get_amount() -> Int {
        
        
        return self.numFriends
    }
    
    var ref: DatabaseReference!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.numFriends
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)
        
        // Configure the cell...
        
        let object = self.keys[indexPath.row]
        
        cell.textLabel?.text = object
        
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destinationVC = segue.destination as? FriendScheduleTableViewController {
            let indexPath = friendsTable.indexPathForSelectedRow
            let right_friend = keys[(indexPath?.row)!]
            destinationVC.friendEmail = right_friend
        }
        
    }

}
