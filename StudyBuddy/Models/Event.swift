//
//  Event.swift
//  StudyBuddy
//
//  Created by Vikram Idury on 10/29/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import Foundation
import UIKit

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

class Event : NSObject {
    var eid: String
    var name: String
    var time: String
    var location: String
    
    init(eid: String, name: String, time: String, location: String) {
        self.eid = eid
        self.name = name
        self.time = time
        self.location = location
    }
    
    convenience override init() {
        self.init(eid: "", name: "", time: "", location:"")
    }
}
