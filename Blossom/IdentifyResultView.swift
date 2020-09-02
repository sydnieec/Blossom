//
//  IdentifyResultView.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-07-27.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//

import SwiftUI
import MapKit



struct IdentifyResultView: View {
    //to get current locations
    @ObservedObject private var locationManager = LocationManager()
    @Binding var identified : String
    @Binding var plantIndex : String
    @Binding var hiddenButton : String
    @EnvironmentObject var settings: UserSettings
    
    //preset descriptions and care tips for a plant 
    @State var descriptionArray: Array = ["The aloe vera plant is an easy, attractive succulent that makes for a great indoor companion. Aloe vera plants are useful, too, as the juice from their leaves can be used to relieve pain from scrapes and burns when applied topically.", "Kalanchoe is a succulent, which means its leaves store water and tends to be on the drier side. As these plants are native to warm, tropical places, it does best in a warm environment.", "Cacti belong to a specific family of plants, but the species within that family come from some very different habitats. Many cacti, such as those in the genus Ferocactus, are in fact true desert dwellers.", "These interesting flowers can be found in a range of colors and sizes depending on the variety. They make excellent accent plantings to nearly any home décor. Orchids require little care once all their basic needs are met such as light, temperature, and humidity.", "Peace lilies are tropical, evergreen plants that thrive on the forest floor, where they receive dappled sunlight and consistent moisture. Replicating these conditions in the home is the key to getting your peace lily to be happy and healthy."]
    @State var careTipsArray: Array = ["1.Place in bright, indirect sunlight or artificial light. A western or southern window is ideal. Aloe that are kept in low light often grow leggy.", "2. Aloe vera do best in temperatures between 55 and 80°F (13 and 27°C)." , "3.To discourage rot, allow the soil to dry at least 1 to 2 inches deep between waterings. Don’t let your plant sit in water.", "4. Water about every 3 weeks and even more sparingly during the winter.", "1. Keep plant warm; temperatures between 13-29 degrees C (55-80 degrees F) would be ideal.", "2. Plant in well-drained, well-aerated soil, such as 50% peat moss and 40% perlite." , "3. It cannot tolerate cold temperatures. Avoid placing plants near drafts or cool window sills.", "4. Use a clay pot to plant the kalanchoe, as the roots can be quite sensitive."," On average, during spring/summer, you can water once a week or even more, depending on whether the soil dries or not.",
                                       "1. For proper care, you need to purchase a fertilizer designed for cacti.",
                                       "2. Desert cacti love direct sunlight and would do with four hours a day of some direct sunlight. The tropical cacti such as Christmas cacti prefer partial shade",
                                       "3. The most common cacti problems are bacterial and fungal diseases caused by overwatering.","Most orchids require moist, well-draining conditions.",
                                       "4. A basic mix for growing orchids consists of coarse perlite, fir bark, and sphagnum moss.",
                                       "1. Place orchids in an east to south-facing window or room. These plants prefer bright, indirect light. ",
                                       "2.They need to be about 15 degrees cooler at night than during the day in order to bloom sufficiently.", "Keep these plants out of direct afternoon sunlight, but in a well-lit area.", "Keep the soil moist, but do not overwater. Peace lilies can tolerate short periods of dry soil, but their leaves will start to brown if neglected for too long.",
                                       "3.Peace lilies are sensitive to chemicals commonly found in tap water, such as fluoride, which may cause brown leaf tips. Use filtered, room-temperature water, if possible.",
                                       "4.Peace lilies enjoy high humidity. Misting their leaves or placing their pot atop a moistened tray of gravel can help to increase humidity. "
    ]
    @State var showAlert = false
    @State var alertsuccess : String = ""
    
    
    var alert : Alert{
        Alert(title: Text("Added to Garden"), message: nil, dismissButton: .default(Text("Cancel")))
    }
    var body: some View {
        let coordinate = self.locationManager.location != nil
            ? self.locationManager.location!.coordinate :
            CLLocationCoordinate2D()
        return VStack{
            Text(identified)
                .font(.system(size: 40))
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 129/225, green: 178/255, blue: 20/255))
                .padding()
            Text("Description")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(Color(red: 21/225, green: 132/255, blue: 103/255))
            Text(descriptionArray[Int(plantIndex)!])
                .multilineTextAlignment(.leading)
                .padding()
            
            Text("Care Tips")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(Color(red: 21/225, green: 132/255, blue: 103/255))
            
            Text(careTipsArray[Int(plantIndex)!*4])
                .padding()
            Text(careTipsArray[Int(plantIndex)!*4+1])
                .padding()
            Text(careTipsArray[Int(plantIndex)!*4+2])
                .padding()
            Text(careTipsArray[Int(plantIndex)!*4+3])
                .padding()
            if (self.hiddenButton=="no"){
                Button(action: {
                    if !self.settings.gardenId.contains(Int(self.plantIndex)!){
                        //add to global variable list in usersettings
                        self.settings.gardenNames.append(self.identified)
                        self.settings.gardenId.append(Int(self.plantIndex)!)
                        //add to annotations list for map
                        let newLocation = MKPointAnnotation()
                        newLocation.title = self.identified
                        newLocation.subtitle = String(self.plantIndex)
                        
                        newLocation.coordinate = coordinate
                        self.settings.locations.append(newLocation)
                        
                        self.showAlert = true
                        self.alertsuccess = "Added to your garden and map"
                    }else{
                        self.showAlert = true
                        self.alertsuccess = "This plant is registered"
                    }
                    
                }) {
                    Text("Add to my profile")
                }.padding()
                    .background(Color(red: 21/225, green: 132/255, blue: 103/255))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .frame(minWidth: 200, minHeight: 100)
                    
                    .alert(isPresented: $showAlert) {Alert(title: Text(alertsuccess), message: nil, dismissButton: .default(Text("Ok")))}
            }
        }
    }
    
}


struct IdentifyResultView_Previews: PreviewProvider {
    static var previews: some View {
        IdentifyResultView(identified: .constant("Plant Name"), plantIndex: .constant("0"), hiddenButton: .constant("no"))
    }
}

