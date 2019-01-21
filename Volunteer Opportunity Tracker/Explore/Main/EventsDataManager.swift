//
//  EventsDataManager.swift
//  Volunteer Opportunity Tracker
//
//  Created by Cindy Zhang on 3/8/18.
//  Copyright © 2018 Cindy Zhang. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase
import FirebaseStorage

class EventsDataManager {
    static var sharedInstance = EventsDataManager()
    
    //MARK: references to firebase server database & storage
    let ref = Database.database().reference(withPath: "event-item")
    let storageRef = Storage.storage().reference()
    let imagesRef:StorageReference
    
    //MARK: arrays of ___
    fileprivate var allEvents = [EventObject]()
    fileprivate var annotations:[EventAnnotation] = []
    
    init(){
        imagesRef = storageRef.child("images");
    }
    
    func getNumberOfItems() -> Int {
        return allEvents.count
    }

    func addEventToDatabase(_ event: EventObject, _ photo: UIImage){
        let key = event.name.lowercased()
        
        // save info to database
        let eventItemRef = self.ref.child(key)
        eventItemRef.setValue(event.toAnyObject())
        
        // save image to storage
        if let uploadData = UIImagePNGRepresentation(photo){
            imagesRef.child(event.key).putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let photoURL = metadata?.downloadURL()?.absoluteString {
                    self.ref.child(key).child("imageURL").setValue(photoURL)
                }
            }
        }
    }

    func removeEventFromDatabase(_ indexPath: IndexPath){
        let event = allEvents[indexPath.row]
        ref.child(event.key).removeValue()
        
        let desertRef = imagesRef.child(event.key)
        desertRef.delete { error in
            if let error = error {
                print ("Uh-oh, an error occurred!", error)
            } else {
                print ("deleted image successfully")
            }
        }
    }

    func getItem(at indexPath: IndexPath) -> EventObject{
        return allEvents[indexPath.item]
    }
    
    func updateEvents(finished: @escaping() -> Void) {
        ref.observeSingleEvent(of: .value, with: { snapshot in
            var newItems: [EventObject] = []
            for item in snapshot.children {
                if ((item as! DataSnapshot).hasChild("imageURL")){
                    let event = EventObject(snapshot: item as! DataSnapshot)
                    newItems.append(event)
                }
            }
            self.allEvents = newItems
            finished()
        })
    }
}

extension EventsDataManager {
    // for managing maps
    func fetchAnnotations(completion: @escaping(_ annotations:[EventAnnotation]) -> ()) {
        updateEvents {
            if self.annotations.count > 0 { self.annotations.removeAll() }
            
            for e in self.allEvents {
                let address = e.address
                
                let geoCoder = CLGeocoder()
                geoCoder.geocodeAddressString(address) { (placemarks, error) in
                    guard let placemarks = placemarks, let location = placemarks.first?.location
                        else {
                            print("no location found", error!)
                            return
                        }
                    self.annotations.append(EventAnnotation(title: e.name, locationName: e.location, discipline: "Sculpture", coordinate: location.coordinate))
                    completion(self.annotations)
                }
            }
        }
    }
    
    func currentRegion (latDelta:CLLocationDegrees, longDelta:CLLocationDegrees) -> MKCoordinateRegion {
        guard let item = annotations.first else { return MKCoordinateRegion() }
        let span = MKCoordinateSpanMake(latDelta, longDelta)
        
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
}
