//
//  InvitedEventTableViewCell.swift
//  StudyBuddy
//
//  Created by Vikram Idury on 10/31/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

class InvitedEventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventLabel: UILabel!
    var eventID: String!
    var ref: DatabaseReference!
    var parentTableVC: EventsTableViewController!
    var event: Event!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func refreshLabels () {
        ref = Database.database().reference()
        ref.child("events").child(eventID).observe(.value, with: { snapshot in
            if snapshot.exists() {
                let mapping = snapshot.value as! [String:String]
                let name = mapping["name"]
                let time = mapping["time"]
                let location = mapping["location"]
                self.event = Event(eid: self.eventID, name: name!, time: time!, location: location!)
                self.eventLabel.text = self.event.name
            }
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func eventAccepted(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        let em = user?.email
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        let userRef = self.ref.child("users").child(em2)
        userRef.child("accepted_events").child(event.eid).setValue(true)
        userRef.child("invited_events").child(event.eid).removeValue { (_, _) in
            if let idx = self.parentTableVC.invitedEventIDs.index(of: self.event.eid) {
                self.parentTableVC.invitedEventIDs.remove(at: idx)
                self.parentTableVC.tableView.deleteRows(at: [IndexPath(row: idx, section: 0)], with: .automatic)
            }
            
        }
        parentTableVC.tableView.reloadData()
    }
    
    @IBAction func eventDeclined(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        let em = user?.email
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        
        let userRef = self.ref.child("users").child(em2)
        userRef.child("invited_events").child(event.eid).removeValue { (_, _) in
            if let idx = self.parentTableVC.invitedEventIDs.index(of: self.event.eid) {
                self.parentTableVC.invitedEventIDs.remove(at: idx)
                self.parentTableVC.tableView.deleteRows(at: [IndexPath(row: idx, section: 0)], with: .automatic)
            }
            
        }
        
    }
    
}
