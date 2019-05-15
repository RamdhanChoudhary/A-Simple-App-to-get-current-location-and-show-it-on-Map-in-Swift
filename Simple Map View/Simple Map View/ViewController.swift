//
//  ViewController.swift
//  Simple Map View
//
//  Created by RAMDHAN CHOUDHARY on 14/05/19.
//  Copyright © 2019 RDC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: Variables declearations
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    // MARK: View Controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Make user you must add following three privacy permissions in plist
        //NSLocationWhenInUseUsageDescription
        //NSLocationAlwaysAndWhenInUseUsageDescription
        //NSLocationAlwaysUsageDescription
        
        getCurrentLocation()
    }

    func getCurrentLocation()
    {
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: Location Manager Delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locationsObj = locations.last! as CLLocation
        print("Current location lat-long is = \(locationsObj.coordinate.latitude) \(locationsObj.coordinate.longitude)")
        showOnMap(location: locationsObj)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Get Location failed")
    }
    
    func showOnMap(location: CLLocation )
    {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
}

