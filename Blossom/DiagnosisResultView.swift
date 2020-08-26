//
//  DiagnosisResultView.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-07-27.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//

import SwiftUI

struct DiagnosisResultView: View {
    @EnvironmentObject var settings: UserSettings
    @Binding var identified : String
    @Binding var diagnosisIndex : Int
    @State var descriptionArray: Array = ["Your plant appears to be overwatered! The first step in saving your overwatered plants is to determine how badly they have been affected.", "Your plant appears to be underwatered! Here are some general things to watch out for to determine if your watering needs adjustments. "]
    @State var techniquesToConsider: Array = [" If the soil is all dark and moist, your plant likely doesn't need water. Add water only when the soil is dry to the touch and light in color", "Do not water at night. Plants that stay moist all night tend to breed disease. Only water at night if your plant has already started to wilt.", "Don't allow your pot to sit in standing water as it will keep the soil too wet.", "Check your pot for proper drainage and, if possible, create additional air space around the roots. ", "To keep things simple, water your plant the same amount each week. (about 2 cups for plants 2-3ft tall and 3 cups for plants 3-6ft tall)" , "The amount of water your plants need will change depending on the season and the conditions in their environment.", "Keep out of strong sunlight, and lightly watered, until there are signs of new growth.", "Put the plant into a sink or bucket of water so that the pot is submerged. Leave for half an hour."]
    @State var careTipsArray : Array = []

    
    var body: some View {

        List {
            HStack{
                Spacer()
                VStack{
                    Text(identified)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(Color(red: 21/225, green: 132/255, blue: 103/255))
                    Text("Description")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(Color(red: 21/225, green: 132/255, blue: 103/255))

                    Text(descriptionArray[self.diagnosisIndex])
                    Text("Techniques to Consider")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(Color(red: 21/225, green: 132/255, blue: 103/255))
                    Text("1. \(techniquesToConsider[self.diagnosisIndex*4])")
                        .padding(.top)
                    Text("2. \(techniquesToConsider[self.diagnosisIndex*4+1])")
                        .padding(.top)
                    Text("3. \(techniquesToConsider[self.diagnosisIndex*4+2])")
                        .padding(.top)
                    Text("4. \(techniquesToConsider[self.diagnosisIndex*4+3])")
                        .padding(.top)

                        Button(action: {
                    self.settings.gardenHistory.append(self.identified)
                    self.settings.gardenHistoryId.append(self.diagnosisIndex)
                      }) {
                      Text("Add to my profile")
                }.padding()
                       .background(Color(red: 21/225, green: 132/255, blue: 103/255))
                       .foregroundColor(Color.white)
                       .cornerRadius(10)
                       .frame(minWidth: 200, minHeight: 100)
//                    Text("Rescue Tips")
//                    .font(.title)
//                        .fontWeight(.semibold)
//                    Text(careTipsArray[self.plantIndex])
//                    Button(action: {
//                        self.settings.gardenNames.append(self.identified)
//                        self.settings.gardenId.append(self.plantIndex)
//
//                    }) {
//                    Text("Add to my garden")
//                    }
                }
                
            }
        }.background(Color.red)
//        .foregroundColor(Color(red: 21/225, green: 132/255, blue: 103/255))
        
  
    }
    
        
}

struct DiagnosisResultView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisResultView(identified: .constant("Plant Name"), diagnosisIndex: .constant(0))
    }
}

//func getDiagnosisIndex(identified: String) -> Int {
//    if identified == "Kalanchoe"{
//        return 1
//    }else {
//        return 2
//    }
//}
//
