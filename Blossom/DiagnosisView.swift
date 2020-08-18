//
//  DiagnosisView.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-07-22.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//

import SwiftUI
import VisualRecognition
struct DiagnosisView: View {
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image : UIImage?
    @State private var resizedimage : UIImage?
    @State private var identified: String = "unknown diagnosis"
    @State private var diagnosisIndex: Int = 0
    
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        NavigationView{
                    VStack{
                        NavigationLink(destination: DiagnosisResultView(identified: self.$identified, diagnosisIndex: self.$diagnosisIndex )) { Text("View Result") }.background(Color.green).cornerRadius(5)
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
                            if (self.image == nil){
                                self.identified="Please Select an image"
                            }else{
                            self.resizedimage = resizeimage(self.image!)
                             self.identified = makeAPICallIdentify(data: self.resizedimage?.pngData() ?? Data())
                            if self.identified == "overwatered"{
                                self.diagnosisIndex = 0
                            }else{
                                self.diagnosisIndex = 1
                                }
                                self.settings.gardenHistory.append(self.identified)
                                self.settings.gardenHistoryId.append(self.diagnosisIndex)

        //                    self.identified = sendPostRequest(data: self.resizedimage?.pngData() ?? Data(), identified: self.identified )

                            }
                        }) {
                            Text("Identify ")
                        }
                    
                        Text(self.identified)
                    }

                    .navigationBarTitle("Diagnosis")
                }.sheet(isPresented: $showImagePicker){
                    ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
                }
                
        
    }

}

struct DiagnosisView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisView()
        .previewDevice(PreviewDevice(rawValue: "iPhone XR"))

    }
}


func makeAPICallIdentify(data: Data) -> String{
     let authenticator = WatsonIAMAuthenticator(apiKey: "OWE4zN1ERqtaeFR-nJ7nJFwRx5xf5WTb4htV2PIE8LA8")
        let visualRecognition = VisualRecognition(version: "2018-03-19", authenticator: authenticator)
        visualRecognition.serviceURL = "https://api.us-south.visual-recognition.watson.cloud.ibm.com/instances/e33cf98c-e21e-4f54-ad1f-47bcad0d85a0"
        var identified =  ""
        //used dispatchsemaphore to await for values
        let semaphore = DispatchSemaphore(value: 0)
        //the api call to classify the image
        visualRecognition.classify(imagesFile: data, classifierIDs: ["DefaultCustomModel_1093971158"]) {
                 response, error in

                   guard let result = response?.result else {
                   print(error?.localizedDescription ?? "unknown error")
                   return
                 }
        print(result)
        //parses the object to only get the flower name
       identified = (response?.result?.images[0].classifiers[0].classes[0].class) as! String
       print(identified)
        //sends a signal to show that the api request has been done
       semaphore.signal()
    }
    // checks if a signal has been received
    _ = semaphore.wait(wallTimeout: .distantFuture)
    return (identified)

}
