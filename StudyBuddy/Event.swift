//
//  Event.swift
//  StudyBuddy
//
//  Created by Vikram Idury on 10/29/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import Foundation
import UIKit
import MapKit

/* 
 events: {
     event_id: {
         host: user_id,
         name: "event_name",
         time: "datetime",
         location: "location"
     }
 }
 */

class Event : NSObject, MKAnnotation {
    var eid: String
    var name: String
    var time: String
    var location: String
    var latitude: String
    var longitude: String
    
    init(eid: String, name: String, time: String, location: String, latitude: String, longitude: String) {
        self.eid = eid
        self.name = name
        self.time = time
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var coordinate: CLLocationCoordinate2D {
        var lat = round(Double(self.latitude)!*10000)/10000
        var long = round(Double(self.longitude)!*10000)/10000
        return CLLocationCoordinate2DMake(lat,long)
    }
    
    convenience override init() {
        self.init(eid: "", name: "", time: "", location:"", latitude:"30.2672", longitude:"-97.7431")
    }
}
