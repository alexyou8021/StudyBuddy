//
//  EventViewController.swift
//  StudyBuddy
//
//  Created by Vikram Idury on 10/31/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import MapKit

class EventViewController: UIViewController {
    

    var eventId: String!
    @IBOutlet weak var eventButton: UIButton!
    var ref: DatabaseReference!
    var deletable: Bool!
    var eventsTableVC: EventsTableViewController!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("events").child(self.eventId).observe(.value, with: { snapshot in
            if snapshot.exists() {
                let mapping = snapshot.value as! [String:String]
                let name = mapping["name"]
                let time = mapping["time"]
                let location = mapping["location"]
                let latitude = mapping["latitude"]
                let longitude = mapping["longitude"]
                var lat = round(Double(latitude!)!*10000)/10000
                var long =  round(Double(longitude!)!*10000)/10000
                self.nameLabel.text = name
                self.timeLabel.text = time
                let initialLocation = CLLocation(latitude: lat, longitude: long)
                let regionRadius = 5000
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate,
                                                                          CLLocationDistance(regionRadius), CLLocationDistance(regionRadius))
                self.mapView.setRegion(coordinateRegion, animated: true)
                self.mapView.addAnnotation(Event(eid: "111", name: name!, time: "Time", location: "initialLocation", latitude: latitude!, longitude: longitude!))
                self.reloadInputViews()
            }
        })
        if !deletable {
            print("test")
            self.eventButton.isHidden = true
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func eventDeleted(_ sender: Any) {
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let em = user?.email
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        self.ref.child("users").child(em2).child("accepted_events").child(eventId).removeValue()
        self.eventButton.isEnabled = false
        self.eventButton.setTitle("Event Deleted", for: .normal)
        self.eventsTableVC.tableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
