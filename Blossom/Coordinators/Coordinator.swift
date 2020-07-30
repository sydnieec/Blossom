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
    init(_ control: MapView){
        self.control = control
        
    }
}
