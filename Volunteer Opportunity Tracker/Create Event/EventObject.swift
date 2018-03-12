//
//  EventObject.swift
//  Volunteer Opportunity Tracker
//
//  Created by Cindy Zhang on 3/4/18.
//  Copyright © 2018 Cindy Zhang. All rights reserved.
//

import Foundation
import UIKit
import os.log

class EventObject: NSObject, NSCoding {
    
    var name: String
    var location: String
    var photo: UIImage?
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("events")
    
    init(name: String, location: String, photo: UIImage?) {
        self.name = name
        self.location = location
        self.photo = photo
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(location, forKey: PropertyKey.location)
        aCoder.encode(photo, forKey: PropertyKey.photo)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        let location = aDecoder.decodeObject(forKey: PropertyKey.location) as? String
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        // Must call designated initializer.
        self.init(name: name!, location: location!, photo: photo)
    }
    
    struct PropertyKey {
        static let name = "name"
        static let location = "location"
        static let photo = "photo"
    }
}
