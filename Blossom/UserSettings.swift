//
//  UserSettings.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-08-17.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//


import Foundation
import MapKit

 class UserSettings : ObservableObject{
    @Published var gardenNames : [String] = ["Kalanchoe"]
    @Published var gardenId : [Int] = [2]

    @Published var gardenHistory : [String] = ["underwatered"]
    @Published var gardenHistoryId : [Int] = [0]
    
    
    @Published  var centerCoordinate = CLLocationCoordinate2D()
    @Published  var locations = [MKPointAnnotation]()
    @Published var showingPlaceDetails = false


 }
