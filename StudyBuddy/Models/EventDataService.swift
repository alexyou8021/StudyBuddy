//
//  EventDataService.swift
//  StudyBuddy
//
//  Created by Vikram Idury on 10/29/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import Foundation

class EventDataService {
    
    static var acceptedEvents: [Event] = [
        Event(eid: "event1", name: "Study for Psych", time: "Tuesday 12:30pm", location: "FAC"),
        Event(eid: "event2", name: "Prepare for Interview", time: "Monday 9:15am", location: "Alex's apartment"),
        Event(eid: "event3", name: "Finish iOS Alpha Release", time: "Friday 1-2pm", location: "GDC")
    ]
    static var invitedEvents: [Event] = [
        Event(eid: "event1", name: "Work on Algo assignment", time: "Monday 5:00pm", location: "FAC"),
        Event(eid: "event2", name: "Go through basketball drills", time: "Thursday 9:00pm", location: "Gregory Gym"),
    ]
    static var friends: [User] = [
        User(uid: "friend1", firstName: "First1", lastName: "Last1", hosted: [], invited: [], accepted: []),
        User(uid: "friend2", firstName: "First2", lastName: "Last2",  hosted: [], invited: [], accepted: []),
        User(uid: "friend3", firstName: "First3", lastName: "Last3",  hosted: [], invited: [], accepted: []),
        User(uid: "friend4", firstName: "First4", lastName: "Last4",  hosted: [], invited: [], accepted: []),
        User(uid: "friend5", firstName: "First5", lastName: "Last5",  hosted: [], invited: [], accepted: []),
    ]
    
    static func fetchAcceptedEvents() -> [Event]{
        return acceptedEvents
    }
    
    static func fetchInvitedEvents() -> [Event] {
        return invitedEvents
    }
    
    static func fetchFriends() -> [User] {
        return friends
    }
    
    static func saveEvent(name: String, time: String, location: String, invites: Set<String>) {
        print(invites)
        let id = arc4random_uniform(100000)
        var event = Event(eid: "event\(id)", name: name, time: time, location: location)
        acceptedEvents.append(event)
    }
    
    static func acceptEventInvite(event: Event) {
        acceptedEvents.append(event)
    }
    
    static func declineEventInvite(event: Event) {
        print("Decline event")
    }
}
