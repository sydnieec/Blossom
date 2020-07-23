//
//  IdentifyView.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-07-22.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//

import SwiftUI

struct IdentifyView: View {
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image : UIImage?
    
    var body: some View {
        NavigationView{
            VStack{
                Image(uiImage: image ?? UIImage(named: "placeholder")!)
                    .resizable()
                    .frame(width:300, height : 300)
                Button("choose picture"){
                    self.showSheet=true
                }.padding()
                    .actionSheet(isPresented: $showSheet){
                        ActionSheet(title: Text("Select Photo"),
                                    message :Text("Choose"), buttons: [.default(Text("Photo Library")){
                                        self.showImagePicker = true
                                        self.sourceType = .photoLibrary
                                        }, .default(Text("Camera")){
                                            self.showImagePicker = true
                                            self.sourceType = .camera
                                        }, .cancel()])
                }
            }
            .navigationBarTitle("Identify")
        }.sheet(isPresented: $showImagePicker){
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
    }
}

struct IdentifyView_Previews: PreviewProvider {
    static var previews: some View {
        IdentifyView()
            .previewDevice(PreviewDevice(rawValue: "iPhone XR"))
        
    }
}

