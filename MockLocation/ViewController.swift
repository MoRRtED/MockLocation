//
//  ViewController.swift
//  MockLocation
//
//  Created by Kyrylo Roman on 5/18/18.
//  Copyright © 2018 Kyrylo Roman. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonItem = MKUserTrackingBarButtonItem.init(mapView: mapView)
        
        self.navigationItem.rightBarButtonItem = buttonItem
        
        self.mapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circle = (overlay as! CustomCircle)
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.fillColor = circle.color
        circleRenderer.alpha = 0.1
        
        return circleRenderer
    }
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 400
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            mapView.showsUserLocation = true
            mapView.userTrackingMode = MKUserTrackingMode.follow
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        } else {
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func showCircle(coordinate: CLLocationCoordinate2D, regRadius: CLLocationDistance, title: String, color: UIColor) {
        let circle = CustomCircle.init(center: coordinate, radius: regRadius)
        circle.color = color
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        self.mapView.addAnnotation(annotation)
        self.mapView.addOverlay(circle)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let goNext = segue.destination as! FenceModalViewController
        
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove )
        mapView.removeOverlays(mapView.overlays)
        goNext.geofences.removeAll()
        
        let user = UserDefaults(suiteName:"group.com.vector-software.smartdok")
        guard let url = user?.string(forKey: "BaseUrl") else { return;}
        guard let token = user?.string(forKey: "Token") else { return; }
     
        let headers: HTTPHeaders = [
            "Token": "\(token)",
            "Accept": "application/json"
        ]
        
        AF.request("\(url)/Geofence/GetMonitoredGeofences", method: .get, headers: headers).responseJSON
            {
                response in
                if let json = response.value as? [Any]
                {
                    for geofence in json.compactMap({$0 as? [String:Any]}) {
                        goNext.geofences.append(Geofence(dictionary: geofence))
                    }

                    for fence in goNext.geofences
                    {
                        let geofenceCoordinate = CLLocationCoordinate2D.init(latitude: fence.latitude, longitude: fence.longitude)
                        self.showCircle(coordinate: geofenceCoordinate, regRadius: CLLocationDistance(truncating: fence.radius), title: fence.name,color: UIColor.green)
                    }
                    
                    goNext.dataSource = GeofenceTableDataSource(geofences: goNext.geofences)
                    goNext.GeofencesList.dataSource = goNext.dataSource
                    goNext.GeofencesList.reloadData()
                }
        }
    }
}




