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
    @State var techniquesToConsider: Array = [" If the soil is all dark and moist, your plant likely doesn't need water. Add water only when the soil is dry to the touch and light in color", "Do not water at night. Plants that stay moist all night tend to breed disease. Only water at night if your plant has already started to wilt.", "Don't allow your pot to sit in standing water as it will keep the soil too wet.", "Check your pot for proper drainage and, if possible, create additional air space around the roots. ", "To keep things simple, water your plant the same amount each week - about 2 cups for plants 2-3ft tall and 3 cups for plants 3-6ft tall." , "The amount of water your plants need will change depending on the season and the conditions in their environment.", "Keep out of strong sunlight, and lightly watered, until there are signs of new growth.", "Put the plant into a sink or bucket of water so that the pot is submerged. Leave for half an hour, then set somewhere to drain for half an hour. "]
    @State var careTipsArray : Array = []
    
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
                    Text(descriptionArray[self.diagnosisIndex])
                    Text("Techniques to Consider")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("1. \(techniquesToConsider[self.diagnosisIndex*4])")
                    Text("2. \(techniquesToConsider[self.diagnosisIndex*4+1])")
                    Text("3. \(techniquesToConsider[self.diagnosisIndex*4+2])")
                    Text("4. \(techniquesToConsider[self.diagnosisIndex*4+3])")


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
                Spacer()
                
            }
        }
        
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
