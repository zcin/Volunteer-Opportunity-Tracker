//
//  EventObject.swift
//  Volunteer Opportunity Tracker
//
//  Created by Cindy Zhang on 3/4/18.
//  Copyright © 2018 Cindy Zhang. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class EventObject: NSObject{
    
    var name: String
    var location: String
    var address: String
    var eventDescription: String
    var date: String
    var startTime: String
    var endTime: String
    var imageURL: String
    
    var key: String
    var ref: DatabaseReference?
    
    override init() {
        self.name = ""
        self.location = ""
        self.address = ""
        self.eventDescription = ""
        self.date = ""
        self.startTime = ""
        self.endTime = ""
        self.imageURL = ""
        
        self.key = ""
        self.ref = nil
    }
    
    init(name: String, location: String, address: String, description: String, date: String, startTime: String, endTime: String) {
        self.name = name
        self.location = location
        self.address = address
        self.eventDescription = description
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.imageURL = ""
        
        self.key = name.lowercased()
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        self.key = snapshot.key
        self.ref = snapshot.ref
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.name = snapshotValue["name"] as! String
        self.location = snapshotValue["location"] as! String
        self.address = snapshotValue["address"] as! String
        self.eventDescription = snapshotValue["description"] as! String
        self.date = snapshotValue["date"] as! String
        self.startTime = snapshotValue["startTime"] as! String
        self.endTime = snapshotValue["endTime"] as! String
        self.imageURL = snapshotValue["imageURL"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "location": location,
            "address": address,
            "description": eventDescription,
            "date": date,
            "startTime": startTime,
            "endTime": endTime
        ]
    }
}

