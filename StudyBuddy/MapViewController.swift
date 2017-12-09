//
//  MapViewController.swift
//  StudyBuddy
//
//  Created by Alexander You on 12/9/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Event Map"
        mapView.delegate = self
        let initialLocation = CLLocation(latitude: 30.2672, longitude: -97.7431)
        let regionRadius = 10000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate,
                                                                  CLLocationDistance(regionRadius), CLLocationDistance(regionRadius))
        mapView.setRegion(coordinateRegion, animated: true)
        
        let ref = Database.database().reference()
        let em = Auth.auth().currentUser?.email!
        let em2 = em?.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        ref.child("users").child(em2!).child("accepted_events").observe(.value, with: { snapshot in
            if snapshot.exists() {
                for child in snapshot.children {
                    ref.child("events").child((child as! DataSnapshot).key).observe(.value, with: { snapshot in
                        if snapshot.exists() {
                            let mapping = snapshot.value as! [String:String]
                            let name = mapping["name"]
                            let time = mapping["time"]
                            let location = mapping["location"]
                            let latitude = mapping["latitude"]
                            let longitude = mapping["longitude"]
                            var lat = round(Double(latitude!)!*10000)/10000
                            var long =  round(Double(longitude!)!*10000)/10000
                            self.mapView.addAnnotation(Event(eid: "", name: name!, time: time!, location: "", latitude: latitude!, longitude: longitude!))
                            //self.reloadInputViews()
                        }
                    })
                }
            }
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let regionRadius = 1000
        let anno = view.annotation as! Event
        let lat = round(Double(anno.latitude)!*10000)/10000
        let long = round(Double(anno.longitude)!*10000)/10000
        let selectedLocation = CLLocation(latitude: lat, longitude: long)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(selectedLocation.coordinate,
                                                                  CLLocationDistance(regionRadius), CLLocationDistance(regionRadius))
        mapView.setRegion(coordinateRegion, animated: true)
        eventNameLabel.text = "\(anno.name)"
        timestampLabel.text = "\(anno.time)"
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
