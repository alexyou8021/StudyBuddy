//
//  EventTableViewCell.swift
//  StudyBuddy
//
//  Created by Vikram Idury on 10/31/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import MapKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventLabel: UILabel!
    var eventId: String!
    var event: Event!
    var ref: DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func refreshLabels () {
        ref = Database.database().reference()
        ref.child("events").child(self.eventId).observe(.value, with: { snapshot in
            if snapshot.exists() {
                let mapping = snapshot.value as! [String:String]
                let name = mapping["name"]
                let time = mapping["time"]
                let location = mapping["location"]
                //let location = CLLocation(latitude: 30.2672, longitude: -97.7431)
                self.event = Event(eid: self.eventId, name: name!, time: time!, location: location!, latitude:"-97.7431", longitude:"30.2672")
                self.eventLabel.text = self.event.name
            }
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
