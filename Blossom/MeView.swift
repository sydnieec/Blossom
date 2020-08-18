//
//  MeView.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-07-27.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//

import SwiftUI

struct MeView: View {
    @EnvironmentObject var settings: UserSettings
    var body: some View {
        NavigationView{
            VStack{
        List{
            ForEach(0 ..< self.settings.gardenNames.count)
            {index in
//                Text(self.settings.gardenNames[index])
//                Text(self.settings.gardenId[index])

//                Text("\(self.settings.gardenNames[index])")
////
                NavigationLink(destination: MeResultView(identified: self.$settings.gardenNames[index], plantIndex: self.$settings.gardenId[index]) ) {   Text("\(self.settings.gardenNames[index])") }



            }
            }
            Spacer()
            Text("Plant History")
                .font(.largeTitle)
               .fontWeight(.heavy)
               .foregroundColor(Color.green)
            List{
                ForEach(0 ..< self.settings.gardenHistory.count)
                    {index in
                        NavigationLink(destination: DiagnosisResultView(identified: self.$settings.gardenHistory[index], diagnosisIndex: self.$settings.gardenHistoryId[index]) ) {   Text("Your plant appeared to be  \(self.settings.gardenHistory[index])") }



                    }
                }
                
            }.navigationBarTitle("My Garden")
              
        }
       
        

    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
