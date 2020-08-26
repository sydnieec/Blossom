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
    @State private var identified: String = "Please select a image to start"
    @State private var diagnosisIndex: Int = 0
    
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        NavigationView{
                    VStack{
                        Spacer()
                        Spacer()
                        Image(uiImage: image ?? UIImage(named: "healthPlaceHolder")!)
                            .resizable()
                            .frame(width:250, height : 250)
                            .cornerRadius(50)
                            .overlay(RoundedRectangle(cornerRadius: 50)
                                                                   .stroke(Color(red: 21/225, green: 132/255, blue: 103/255), lineWidth: 4))
                          
                        Text(self.identified)
                        if (self.identified ==  "Please select a image to start" && self.identified != "Please Select an image" ){
                                            NavigationLink(destination: DiagnosisResultView(identified: self.$identified, diagnosisIndex: self.$diagnosisIndex )) { Text("More information") }
                        }
                        Spacer()

                        Button("Choose a picture"){
                            self.showSheet=true
                        }.padding()
                        .background(Color(red: 21/225, green: 132/255, blue: 103/255))
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
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
                            if self.identified == "overwater"{
                                self.identified="Overwatered"
                                self.diagnosisIndex = 0
                            }else{
                                self.identified="Underwatered"
                                self.diagnosisIndex = 1
                                }
                             
        //                    self.identified = sendPostRequest(data: self.resizedimage?.pngData() ?? Data(), identified: self.identified )

                            }
                        }) {
                            Text("Start Diagnosis ")
                            }.padding()
                            .background(Color(red: 21/225, green: 132/255, blue: 103/255))
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)
                            .frame(minWidth: 200, minHeight: 100)
                    Spacer()
                    Spacer()
                    
                    }
                    .navigationBarTitle("Diagnosis")
            
                }
        .sheet(isPresented: $showImagePicker){
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
