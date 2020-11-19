//
//  Geofence.swift
//  MockLocation
//
//  Created by Kyrylo Roman on 3/10/19.
//  Copyright © 2019 Kyrylo Roman. All rights reserved.
//
import CoreLocation

class Geofence {
    
    //MARK: Properties
    var name: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var radius: NSNumber
    
    //MARK: Initialization
    
    init?(name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.radius = 200
        
    }
    
    init(dictionary: [String:Any]) {
        
        self.name = dictionary["ParentName"] as! String
        self.latitude = dictionary["Latitude"] as! CLLocationDegrees
        self.longitude = dictionary["Longitude"] as! CLLocationDegrees
        self.radius = dictionary["GeofenceRadius"] as! NSNumber
    }
}
