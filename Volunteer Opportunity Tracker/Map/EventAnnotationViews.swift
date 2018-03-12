//
//  EventMarkerView.swift
//  Volunteer Opportunity Tracker
//
//  Created by Cindy Zhang on 3/7/18.
//  Copyright © 2018 Cindy Zhang. All rights reserved.
//

import Foundation
import MapKit

class EventMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let event = newValue as? EventAnnotation else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            // 2
            markerTintColor = event.markerTintColor
//            glyphText = String(artwork.discipline.first!)
            if let imageName = event.imageName {
                glyphImage = UIImage(named: imageName)
            } else {
                glyphImage = nil
            }
        }
    }
}

class EventView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let eventAnnotation = newValue as? EventAnnotation else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)

            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "GetDirectionsIcon"), for: UIControlState())
            rightCalloutAccessoryView = mapsButton
            
            
            if let imageName = eventAnnotation.imageName { image = UIImage(named: imageName) }
            else { image = nil }
        }
    }
}
