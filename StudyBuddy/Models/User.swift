//
//  User.swift
//  StudyBuddy
//
//  Created by Vikram Idury on 10/29/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//
/*
 
 users: {
     user_id: {
         (... other data ...)
         hosted_events: [event1_id, event2_id, ...]
         invited_events: [...]
         accepted_events: [...]
     }
 }
 */
import Foundation

class User : NSObject {
    var uid: String
    var firstName: String
    var lastName: String
    var hostedEvents: [String]
    var invitedEvents: [String]
    var acceptedEvents: [String]
    
    init(uid: String, firstName: String, lastName: String, hosted: [String], invited: [String], accepted: [String]) {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.acceptedEvents = accepted
        self.invitedEvents = invited
        self.hostedEvents = hosted
    }
    convenience override init() {
        self.init(uid: "", firstName: "", lastName: "", hosted: [], invited: [], accepted: [])
    }
}
