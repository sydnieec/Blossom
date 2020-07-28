//
//  DiagnosisResultView.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-07-27.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//

import SwiftUI

struct DiagnosisResultView: View {
    @Binding var identified : String
    @State var plantIndex : Int = 2
    @State var descriptionArray: Array = ["The aloe vera plant is an easy, attractive succulent that makes for a great indoor companion. Aloe vera plants are useful, too, as the juice from their leaves can be used to relieve pain from scrapes and burns when applied topically.", "Kalanchoe is a succulent, which means its leaves store water and tends to be on the drier side. As these plants are native to warm, tropical places, it does best in a warm environment.", "Cacti belong to a specific family of plants, but the species within that family come from some very different habitats. Many cacti, such as those in the genus Ferocactus, are in fact true desert dwellers.", "These interesting flowers can be found in a range of colors and sizes depending on the variety. They make excellent accent plantings to nearly any home décor. Orchids require little care once all their basic needs are met such as light, temperature, and humidity.", "Peace lilies are tropical, evergreen plants that thrive on the forest floor, where they receive dappled sunlight and consistent moisture. Replicating these conditions in the home is the key to getting your peace lily to be happy and healthy."]
    @State var careTipsArray: Array = ["Place in bright, indirect sunlight or artificial light. A western or southern window is ideal. Aloe that are kept in low light often grow leggy.", "Aloe vera do best in temperatures between 55 and 80°F (13 and 27°C)." , "To discourage rot, allow the soil to dry at least 1 to 2 inches deep between waterings. Don’t let your plant sit in water.", "Water about every 3 weeks and even more sparingly during the winter.", "Keep plant warm; temperatures between 13-29 degrees C (55-80 degrees F) would be ideal.", "Plant in well-drained, well-aerated soil, such as 50% peat moss and 40% perlite." , "It cannot tolerate cold temperatures. Avoid placing plants near drafts or cool window sills.", "Use a clay pot to plant the kalanchoe, as the roots can be quite sensitive."," On average, during spring/summer, you can water once a week or even more, depending on whether the soil dries or not.",
    "For proper care, you need to purchase a fertilizer designed for cacti.",
    "Desert cacti love direct sunlight and would do with four hours a day of some direct sunlight. The tropical cacti such as Christmas cacti prefer partial shade",
    "The most common cacti problems are bacterial and fungal diseases caused by overwatering.","Most orchids require moist, well-draining conditions.",
     "A basic mix for growing orchids consists of coarse perlite, fir bark, and sphagnum moss.",
   "Place orchids in an east to south-facing window or room. These plants prefer bright, indirect light. ",
   "They need to be about 15 degrees cooler at night than during the day in order to bloom sufficiently.", "Keep these plants out of direct afternoon sunlight, but in a well-lit area.", "Keep the soil moist, but do not overwater. Peace lilies can tolerate short periods of dry soil, but their leaves will start to brown if neglected for too long.",
   "Peace lilies are sensitive to chemicals commonly found in tap water, such as fluoride, which may cause brown leaf tips. Use filtered, room-temperature water, if possible.",
   "Peace lilies enjoy high humidity. Misting their leaves or placing their pot atop a moistened tray of gravel can help to increase humidity. "
]
    
    var body: some View {
        List {
            HStack{
                VStack{
                    Text(identified)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.green)
                        .multilineTextAlignment(.center)
                    Text("Description")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(descriptionArray[self.plantIndex])
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                    Text("Charateristics")
                    .font(.title)
                    .fontWeight(.semibold)
                    Text("Care Tips")
                    .font(.title)
                        .fontWeight(.semibold)
                    Text(careTipsArray[self.plantIndex])
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Add to my garden")
                    }
                }
                Spacer()
            }
        }
        
    }
}

struct DiagnosisResultView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisResultView(identified: .constant("Plant Name"))
    }
}

func getDiagnosisIndex(identified: String) -> Int {
    if identified == "Kalanchoe"{
        return 1
    }else {
        return 2
    }
}

