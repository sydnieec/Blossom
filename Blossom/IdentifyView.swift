//
//  IdentifyView.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-07-22.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//

import SwiftUI
import VisualRecognition

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
                Button(action: {
                    sendPostRequest()
                }) {
                    Text("Identify ")
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


func sendPostRequest(){
    let authenticator = WatsonIAMAuthenticator(apiKey: "OWE4zN1ERqtaeFR-nJ7nJFwRx5xf5WTb4htV2PIE8LA8")
    let visualRecognition = VisualRecognition(version: "2018-03-19", authenticator: authenticator)
    visualRecognition.serviceURL = "https://api.us-south.visual-recognition.watson.cloud.ibm.com/instances/e33cf98c-e21e-4f54-ad1f-47bcad0d85a0"

   let url = Bundle.main.url(forResource: "fruitbowl", withExtension: "jpg")
    let fruitbowl = try? Data(contentsOf: url!)
    print("SDF")
    visualRecognition.classify(imagesFile: fruitbowl, classifierIDs: ["food"]) {
      response, error in
           print("SDF")
      guard let result = response?.result else {
        print(error?.localizedDescription ?? "unknown error")
        return
      }

      print(result)
    }
}
