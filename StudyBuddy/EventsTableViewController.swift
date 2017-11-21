//
//  EventsTableViewController.swift
//  StudyBuddy
//
//  Created by Vikram Idury on 10/29/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class EventsTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventsToggle: UISegmentedControl!
    
    var ref: DatabaseReference!

    var acceptedEventIDs: [String] = []
    var invitedEventIDs: [String] = []

    
    var mode = ListMode.accepted
    enum ListMode {
        case accepted
        case invited
    }

    @IBAction func eventsToggled(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            mode = ListMode.accepted
        } else {
            mode = ListMode.invited
        }
        tableView.reloadData()
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchAll()
    }
    
    func fetchAll() {
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let em = user?.email
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        
        let userRef = self.ref.child("users").child(em2)
        fetchEvents(userRef: userRef, attribute: "invited_events")
        fetchEvents(userRef: userRef, attribute: "accepted_events")
    }
    
    private func fetchEvents(userRef: DatabaseReference, attribute: String) {
        userRef.child(attribute).observe(.value, with: { snapshot in
            if snapshot.exists() {
                let mapping = snapshot.value as! [String:Bool]
                let eventIDs = Array(mapping.keys)
                print(eventIDs)
                switch attribute {
                case "invited_events":
                    self.invitedEventIDs = eventIDs
                    break
                case "accepted_events":
                    self.acceptedEventIDs = eventIDs
                    break
                default:
                    break
                }
                self.tableView.reloadData()
            }
        })
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mode == ListMode.accepted {
            return acceptedEventIDs.count
        } else {
            return invitedEventIDs.count
        }
    }


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mode == ListMode.accepted {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
            cell.eventId = self.acceptedEventIDs[indexPath.row]
            cell.refreshLabels()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventInviteCell", for: indexPath) as! InvitedEventTableViewCell
            cell.eventID = self.invitedEventIDs[indexPath.row]
            cell.parentTableVC = self
            cell.refreshLabels()
            return cell
        }
 
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "viewEventSegue" {
            let seg = segue.destination as! EventViewController
            // Pass the selected object to the new view controller.
            if let indexPath = self.tableView.indexPathForSelectedRow {
                seg.eventId = acceptedEventIDs[indexPath.row]
                seg.eventsTableVC = self
            }
        } else if segue.identifier == "addEventSegue" {
            
        }
        
    }

}
