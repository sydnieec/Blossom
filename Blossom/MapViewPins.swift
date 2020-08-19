//
//  MapViewPins.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-08-19.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//
import MapKit
import SwiftUI

struct MapViewPins: UIViewRepresentable {
    @EnvironmentObject var settings: UserSettings
    @Binding  var selectedPlace: MKPointAnnotation?
    var annotations: [MKPointAnnotation]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        return mapView
    }
   func updateUIView(_ view: MKMapView, context: Context) {
    if annotations.count != view.annotations.count {
            view.removeAnnotations(view.annotations)
        view.addAnnotations(annotations)
        }
    }
   

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewPins

        init(_ parent: MapViewPins) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.settings.centerCoordinate = mapView.centerCoordinate
        }
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // this is our unique identifier for view reuse
            let identifier = "Placemark"

            // attempt to find a cell we can recycle
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                // we didn't find one; make a new one
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)

                // allow this to show pop up information
                annotationView?.canShowCallout = true

                // attach an information button to the view
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                // we have a view to reuse, so give it the new annotation
                annotationView?.annotation = annotation
            }
            // whether it's a new view or a recycled one, send it back
            return annotationView
        }
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let placemark = view.annotation as? MKPointAnnotation else { return }

            parent.selectedPlace = placemark
            parent.settings.showingPlaceDetails = true
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
}
extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

struct MapViewPins_Previews: PreviewProvider {
    static var previews: some View {
        MapViewPins(selectedPlace: .constant(MKPointAnnotation.example), annotations: [MKPointAnnotation.example])

    }
}
