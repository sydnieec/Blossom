//
//  ShareView.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-07-22.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//

import SwiftUI
import MapKit
struct ShareView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false

//    code for MapViewPins.swift
    var body : some View {
         ZStack {
            MapViewPins(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                 .edgesIgnoringSafeArea(.all)
//            MapView()
             Circle()
                 .fill(Color.blue)
                 .opacity(0.3)
                 .frame(width: 32, height: 32)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                       let newLocation = MKPointAnnotation()
                        newLocation.title = "Example location"
                        newLocation.coordinate = self.centerCoordinate
                        self.locations.append(newLocation)
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
         }
        .alert(isPresented: $showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                // edit this place
            })
        }
    }
//    @ObservedObject private var locationManager = LocationManager()
//    var body: some View {
//        let coordinate = self.locationManager.location != nil
//                   ? self.locationManager.location!.coordinate :
//                   CLLocationCoordinate2D()
//        return ZStack{
//            MapView()
////            Text("\(coordinate.latitude), \(coordinate.longitude)")
////                .foregroundColor(Color.white)
////                .padding()
////                .background(Color.green)
////                .cornerRadius(10)
//        }
//    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
        .previewDevice(PreviewDevice(rawValue: "iPhone XR"))

    }
}
