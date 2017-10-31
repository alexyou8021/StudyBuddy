//
//  EventsTableViewController.swift
//  StudyBuddy
//
//  Created by Vikram Idury on 10/29/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit

class EventsTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventsToggle: UISegmentedControl!

    var acceptedEvents: [Event]!
    var invitedEvents: [Event]!
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
        reloadTable()
    }
    
    func reloadTable(){
        acceptedEvents = EventDataService.fetchAcceptedEvents()
        invitedEvents = EventDataService.fetchInvitedEvents()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        reloadTable()
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
            return acceptedEvents.count
        } else {
            return invitedEvents.count
        }
    }


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mode == ListMode.accepted {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
            cell.eventLabel?.text = acceptedEvents[indexPath.row].name
            cell.event = acceptedEvents[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventInviteCell", for: indexPath) as! InvitedEventTableViewCell
            cell.eventLabel?.text = invitedEvents[indexPath.row].name
            cell.event = invitedEvents[indexPath.row]
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
                seg.event = acceptedEvents[indexPath.row]
            }
        } else if segue.identifier == "addEventSegue" {
            
        }
        
    }

}
