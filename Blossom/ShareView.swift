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
    @ObservedObject private var locationManager = LocationManager()
    var body: some View {
        let coordinate = self.locationManager.location != nil
                   ? self.locationManager.location!.coordinate :
                   CLLocationCoordinate2D()
        return ZStack{
            MapView()
            Text("\(coordinate.latitude), \(coordinate.longitude)")
                .foregroundColor(Color.white)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
        }
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
        .previewDevice(PreviewDevice(rawValue: "iPhone XR"))

    }
}
