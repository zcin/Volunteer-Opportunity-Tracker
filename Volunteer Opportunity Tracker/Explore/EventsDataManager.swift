//
//  EventsDataManager.swift
//  Volunteer Opportunity Tracker
//
//  Created by Cindy Zhang on 3/8/18.
//  Copyright © 2018 Cindy Zhang. All rights reserved.
//

import Foundation
import os.log

class EventsDataManager {
    static var sharedInstance = EventsDataManager()

    var allEvents = [EventObject]()
    
    init(){
        if let savedEvents = loadEvents() { allEvents += savedEvents }
    }
    
    func getNumberOfItems() -> Int {
        return allEvents.count
    }
    
    func addEvent(_ event: EventObject){
        allEvents.append(event)
    }
    
    func removeEvent(_ indexPath: IndexPath){
        allEvents.remove(at: indexPath.row)
    }
    
    func getItem(at indexPath: IndexPath) -> EventObject{
        return allEvents[indexPath.item]
    }
    
    func saveEventsToArchive() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(allEvents, toFile: EventObject.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Events successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save events...", log: OSLog.default, type: .error)
        }
    }
    
    func updateEventsFromArchive() {
        if let allEvents = loadEvents() {
            self.allEvents = allEvents
        }
    }
    
    func loadEvents() -> [EventObject]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: EventObject.ArchiveURL.path) as? [EventObject]
    }
    
}
