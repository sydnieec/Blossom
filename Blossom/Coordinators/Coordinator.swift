//
//  Coordinator.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-07-30.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//

import Foundation
import MapKit

final class Coordinator: NSObject, MKMapViewDelegate{
    
    var control : MapView
    //how to zoom and move about the map
    init(_ control: MapView){
        self.control = control
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifer = "Placemark"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifer)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifer)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    //function to zoom onto user location upon opening screen
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let annotationView = views.first{
            if let annotation = annotationView.annotation{
                //checks if user location
                if annotation is MKUserLocation{
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    mapView.setRegion(region, animated: true)
                }
            }
        }
    }
}
