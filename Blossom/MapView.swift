//
//  MapView.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-07-30.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//

import SwiftUI
import MapKit
struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) ->  MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
        
    }
    
    func updateUIView(_ uiView:  MKMapView, context: UIViewRepresentableContext<MapView>) {
        
    }
}

