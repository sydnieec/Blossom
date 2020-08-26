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
//    @State private var centerCoordinate = CLLocationCoordinate2D()
//    @State private var locations = [MKPointAnnotation]()
    @State  var selectedPlace: MKPointAnnotation?
//   @State private var showingPlaceDetails = false
    @EnvironmentObject var settings: UserSettings
    @State var offset : CGFloat = UIScreen.main.bounds.height

//    code for MapViewPins.swift
    var body : some View {
         ZStack {
            MapViewPins( selectedPlace: $selectedPlace, annotations: settings.locations)
                 .edgesIgnoringSafeArea(.all)
//            MapView()
             Circle()
                 .fill(Color.blue)
                 .opacity(0.3)
                 .frame(width: 32, height: 32)
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Button(action: {
//                       let newLocation = MKPointAnnotation()
//                        newLocation.title = "Example location"
//                        newLocation.coordinate = self.settings.centerCoordinate
//                        self.settings.locations.append(newLocation)
//                    }) {
//                        Image(systemName: "plus")
//                    }
//                    .padding()
//                    .background(Color.black.opacity(0.75))
//                    .foregroundColor(.white)
//                    .font(.title)
//                    .clipShape(Circle())
//                    .padding(.trailing)
//                }
//            }
                VStack{
                    
                    Spacer()
                    
                    CustomActionSheet(selectedPlace: $selectedPlace)
                        .offset(y: self.settings.offset)
                    .gesture(DragGesture()
                    
                        .onChanged({ (value) in
                            
                            if value.translation.height > 0{
                                
                                self.settings.offset = value.location.y
                                
                            }
                        })
                        .onEnded({ (value) in
                            
                            if self.settings.offset > 100{
                                
                                self.settings.offset = UIScreen.main.bounds.height
                            }
                            else{
                                
                                self.settings.offset = 0
                            }
                        })
                    )
                    
                }.background((self.offset <= 100 ? Color(UIColor.label).opacity(0.3) : Color.clear).edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                    
                        self.settings.offset = 0
                    
                })
                
                .edgesIgnoringSafeArea(.bottom)
                
            }.animation(.default)
         
//         .alert(isPresented: self.$settings.showingPlaceDetails) {
//            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                // edit this place
            
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


struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
        .previewDevice(PreviewDevice(rawValue: "iPhone XR"))

    }
}

struct CustomActionSheet : View {
    @EnvironmentObject var settings: UserSettings

    @Binding var selectedPlace: MKPointAnnotation?
    @State private var diagnosisIndex: String = "0"


    var body : some View{
        VStack(spacing: 15){
            IdentifyResultView(identified: .constant(selectedPlace?.title ?? "Could not get info"), plantIndex: .constant(selectedPlace?.subtitle ?? self.diagnosisIndex), hiddenButton: .constant("yes"))
//            NavigationView{
//                VStack{
//                Text(selectedPlace?.title ?? "Unknown")
////                Text(selectedPlace?.subtitle ?? "Unknown")
//
//                    NavigationLink(destination: IdentifyResultView(identified: .constant(selectedPlace?.title ?? "Could not get info"), plantIndex: .constant(selectedPlace?.subtitle ?? self.diagnosisIndex)))
//                    { Text("More Information") }.background(Color.green).cornerRadius(5)
//                }
                
            


            
        }.padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        .padding(.horizontal)
        .padding(.top,20)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(25)
        
    }
}
