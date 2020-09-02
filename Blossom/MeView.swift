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
    @State private var hiddenButtonBool: String = "yes"
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Image(systemName: "tray")
                        .foregroundColor(Color(red: 21/225, green: 132/255, blue: 103/255)) .multilineTextAlignment(.leading)
                        .font(.system(size: 30))
                    
                    Text("My Plants")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color(red: 21/225, green: 132/255, blue: 103/255)) .multilineTextAlignment(.leading)
                }
                
                List{
                    ForEach(1 ..< self.settings.gardenNames.count)
                    {index in
                        
                        NavigationLink(destination: MeResultView(identified: self.$settings.gardenNames[index], plantIndex: self.$settings.gardenId[index]) ) {   Text("\(self.settings.gardenNames[index])") }
                        
                    }
                }
                Spacer()
                HStack{
                    Image(systemName: "heart")
                        .foregroundColor(Color(red: 21/225, green: 132/255, blue: 103/255)) .multilineTextAlignment(.leading)
                        .font(.system(size: 30))
                    
                    Text("Plant History")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color(red: 21/225, green: 132/255, blue: 103/255)) .multilineTextAlignment(.leading)
                }
                List{
                    ForEach(1 ..< self.settings.gardenHistory.count)
                    {index in
                        NavigationLink(destination: MeDiagnosisView(identified: self.$settings.gardenHistory[index], diagnosisIndex: self.$settings.gardenHistoryId[index]) ) {   Text("Your plant appeared to be \(self.settings.gardenHistory[index])") }
                        
                    }
                }
                
            }
            
        }
        
        
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
