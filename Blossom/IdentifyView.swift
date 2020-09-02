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
    @State private var resizedimage : UIImage?
    @State private var identified: String = "Please select an image to start "
    @State private var plantIndex: String = "0"
    @State private var hiddenButtonBool: String = "no"
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                Spacer()
                Image(uiImage: image ?? UIImage(named: "placeholder")!)
                    .resizable()
                    .frame(width:250, height : 250)
                    .cornerRadius(50)
                    .overlay(RoundedRectangle(cornerRadius: 50)
                        .stroke(Color(red: 21/225, green: 132/255, blue: 103/255), lineWidth: 4))
                Text(self.identified)
                if (self.identified !=  "Please select an image to start " && self.identified != "Please Select an image"){
                    NavigationLink(destination: IdentifyResultView(identified: self.$identified, plantIndex: self.$plantIndex, hiddenButton: self.$hiddenButtonBool)) { Text("More info") }
                    
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
                        self.identified = makeAPICall(data: self.resizedimage?.pngData() ?? Data())
                        //get a index according to the flower obtained
                        if self.identified == "aloe"{
                            self.plantIndex = "0"
                        }
                        else if self.identified == "Kalanchoe"{
                            self.plantIndex = "1"
                        }else if self.identified == "cactus"{
                            self.plantIndex = "2"
                        }else if self.identified == "orchids"{
                            self.plantIndex = "3"
                        }else if self.identified == "peace lily"{
                            self.plantIndex = "4"
                        }
                        
                    }
                }) {
                    Text("Start Identifying ")
                }.padding()
                    .background(Color(red: 21/225, green: 132/255, blue: 103/255))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .frame(minWidth: 200, minHeight: 100)
                
                Spacer()
                Spacer()
                
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




//function to resize ui image before upload, Watson visual recognisition expects small upload size
func resizeimage(_ image: UIImage) -> UIImage {
    var actualHeight = Float(image.size.height)
    var actualWidth = Float(image.size.width)
    let maxHeight: Float = 300.0
    let maxWidth: Float = 400.0
    var imgRatio: Float = actualWidth / actualHeight
    let maxRatio: Float = maxWidth / maxHeight
    let compressionQuality: Float = 0.5
    //50 percent compression
    if actualHeight > maxHeight || actualWidth > maxWidth {
        if imgRatio < maxRatio {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight
            actualWidth = imgRatio * actualWidth
            actualHeight = maxHeight
        }
        else if imgRatio > maxRatio {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth
            actualHeight = imgRatio * actualHeight
            actualWidth = maxWidth
        }
        else {
            actualHeight = maxHeight
            actualWidth = maxWidth
        }
    }
    let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
    UIGraphicsBeginImageContext(rect.size)
    image.draw(in: rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    let imageData = img?.jpegData(compressionQuality: CGFloat(compressionQuality))
    UIGraphicsEndImageContext()
    return UIImage(data: imageData!) ?? UIImage()
}


//makes the API cal to identify the plant from Watson API
func makeAPICall(data: Data) -> String{
    let authenticator = WatsonIAMAuthenticator(apiKey: "OWE4zN1ERqtaeFR-nJ7nJFwRx5xf5WTb4htV2PIE8LA8")
    let visualRecognition = VisualRecognition(version: "2018-03-19", authenticator: authenticator)
    visualRecognition.serviceURL = "https://api.us-south.visual-recognition.watson.cloud.ibm.com/instances/e33cf98c-e21e-4f54-ad1f-47bcad0d85a0"
    var identified =  ""
    //used dispatchsemaphore to await for values
    let semaphore = DispatchSemaphore(value: 0)
    //the api call to classify the image
    visualRecognition.classify(imagesFile: data, classifierIDs: ["blossom2_167029230"]) {
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


//PREVIOUS POST REQUEST 
//func sendPostRequest(data: Data, identified: String) -> String{
//    let authenticator = WatsonIAMAuthenticator(apiKey: "OWE4zN1ERqtaeFR-nJ7nJFwRx5xf5WTb4htV2PIE8LA8")
//    let visualRecognition = VisualRecognition(version: "2018-03-19", authenticator: authenticator)
//    visualRecognition.serviceURL = "https://api.us-south.visual-recognition.watson.cloud.ibm.com/instances/e33cf98c-e21e-4f54-ad1f-47bcad0d85a0"
//
//         DispatchQueue.main.async {
//            visualRecognition.classify(imagesFile: data, classifierIDs: ["blossom2_167029230"]) {
//                     response, error in
//                          //use po error to check what error description you are getting
//               //        print(response?.result?.images.description)
//               //        print(response?.result?.images)
//                       guard let result = response?.result else {
//                       print(error?.localizedDescription ?? "unknown error")
//                       return
//                     }
//            print(result)
//            let identified = (response?.result?.images[0].classifiers[0].classes[0].class) as! String
//           print(identified)
//        }
//
//    }
//    print (identified)
//    return (identified)
//
//}
