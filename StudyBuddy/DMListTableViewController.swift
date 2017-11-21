//
//  DMListTableViewController.swift
//  StudyBuddy
//
//  Created by Alexander You on 11/20/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class DMListTableViewController: UITableViewController {
    
    var ref: DatabaseReference!
    var friends:[String:Bool] = [:]
    var keys:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let em = user?.email
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        
        self.ref?.child("users").child(em2).child("friends").observe(.value, with: { snapshot in
            if snapshot.exists() {
                self.friends = snapshot.value as! [String: Bool]
                self.keys = Array(self.friends.keys)
                self.tableView.reloadData()
            } else {
                print("x")
                self.friends = [:]
                self.keys = []
            }
        })
        print(self.friends)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return self.keys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DM", for: indexPath)
        cell.textLabel?.text = self.keys[indexPath.item]
        // Configure the cell...
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destinationVC = segue.destination as? DMViewController {
            let indexPath = self.tableView.indexPathForSelectedRow
            let friend = keys[(indexPath?.row)!]
            destinationVC.friendEmail = friend.replacingOccurrences(of: ".", with: "dot")
        }
    }
}
