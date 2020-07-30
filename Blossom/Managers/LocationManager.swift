//
//  LocationManager.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-07-30.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//

import Foundation
import MapKit
class LocationManager: NSObject, ObservableObject{
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}


extension LocationManager: CLLocationManagerDelegate{
    
    //updates if the location changed 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else{
            return
        }
        self.location = location
    }
}
