//
//  GeofenceTableDataSource.swift
//  MockLocation
//
//  Created by Kyrylo Roman on 3/11/19.
//  Copyright © 2019 Kyrylo Roman. All rights reserved.
//

import UIKit

class GeofenceTableDataSource: NSObject, UITableViewDataSource {
    var geofences :[Geofence]
    
    init(geofences:[Geofence]) {
        self.geofences = geofences
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return geofences.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "GeofenceTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,                                          for: indexPath) as? GeofenceTableViewCell  else {
            fatalError("The dequeued cell is not an instance of GeofenceTableViewCell.")
        }
        
        let geofence = geofences[indexPath.row]
        cell.FenceName.text = geofence.name
        cell.Latitude.text = String(geofence.latitude)
        cell.Longitude.text = String(geofence.longitude)
        
        return cell
    }
}
