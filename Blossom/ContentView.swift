//
//  ContentView.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-07-22.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//

import SwiftUI
import MapKit
struct ContentView: View {
    @State private var selection = 0
    //observed if any time location manager throws a new value, body will be rerendered
//    @ObservedObject private var locationManager = LocationManager()
    var body: some View {
//        let coordinate = self.locationManager.location != nil
//            ? self.locationManager.location!.coordinate :
//            CLLocationCoordinate2D()
        TabView(selection: $selection){
            DiagnosisView()
                .tabItem {
                    VStack {
                        Image(systemName: "heart")
                        Text("Diagnosis")
                    }
                }
                .tag(0)
            IdentifyView()
                .tabItem {
                    VStack {
                        Image(systemName: "camera")
                        Text("Identify")
                    }
                }
                .tag(1)
            ShareView()
                .tabItem {
                    VStack {
                        Image(systemName: "map")
                        Text("Share")
                    }
                }
                .tag(2)
            MeView()
                         .tabItem {
                             VStack {
                                 Image(systemName: "person")
                                 Text("Me")
                             }
                         }
                         .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .previewDevice(PreviewDevice(rawValue: "iPhone XR"))

    }
}
