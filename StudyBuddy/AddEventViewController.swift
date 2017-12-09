//
//  AddEventViewController.swift
//  StudyBuddy
//
//  Created by Vikram Idury on 10/29/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import MapKit

class AddEventViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate {
    @IBOutlet weak var timeField: UIDatePicker!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet var mapView: MKMapView!

    var selectedFriends: Set<String>!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let initialLocation = CLLocation(latitude: 30.2672, longitude: -97.7431)
        let regionRadius = 10000
        
        //mapView.setCenter(CLLocationCoordinate2DMake(30.2672, -97.7431), animated: false)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate,
                                                                  CLLocationDistance(regionRadius), CLLocationDistance(regionRadius))
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(Event(eid: "111", name: "Funs", time: "Time", location: "initialLocation", latitude:"30.2672", longitude:"-97.7431"))
        ref = Database.database().reference()
        nameField.delegate = self
        selectedFriends = Set<String>()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addEvent(_ sender: UIButton) {
        let name = nameField.text!
        let timestamp = timeField.date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        let time = formatter.string(from: timestamp)
        var location = "location"
        if (name.characters.count > 0 && time.characters.count > 0 && location.characters.count > 0){
            saveEvent(name: name, time: time, location: location, invites: selectedFriends, latitude: "\(mapView.centerCoordinate.latitude)", longitude: "\(mapView.centerCoordinate.longitude)")
            statusLabel.text = "Event added successfully"
        } else {
           statusLabel.text = "Must fill out all fields"
        }
    }
    
    func saveEvent(name: String, time: String, location: String, invites: Set<String>, latitude: String, longitude: String){
        let user = Auth.auth().currentUser
        let users = self.ref.child("users")
        let em = user?.email
        let events = self.ref.child("events")
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        
        let newEvent = events.childByAutoId()
        newEvent.setValue([
            "host": em2,
            "name": name,
            "time": time,
            "location": location,
            "latitude": latitude,
            "longitude": longitude
        ])
        let eventId = newEvent.key
        users.child(em2).child("accepted_events").child(eventId).setValue(true)
        for id in invites {
            let friend = users.child(id)
            friend.child("invited_events").child(eventId).setValue(true)
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        mapView.removeAnnotations(mapView.annotations)
        let center = mapView.centerCoordinate
        print(center)
        mapView.addAnnotation(Event(eid: "111", name: "Funs", time: "Time", location: "initialLocation", latitude:"\(center.latitude)", longitude:"\(center.longitude)"))
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let seg = segue.destination as! EventFriendsTableViewController
        // Pass the selected object to the new view controller.
        seg.addEventVC = self
    }
    
    // Below code taken from TestKeyboardDismiss
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
