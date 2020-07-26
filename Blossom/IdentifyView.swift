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
                    self.resizedimage = resizeimage(self.image!)
                    sendPostRequest(data: self.resizedimage?.pngData() ?? Data())
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


func sendPostRequest(data: Data){
    let authenticator = WatsonIAMAuthenticator(apiKey: "OWE4zN1ERqtaeFR-nJ7nJFwRx5xf5WTb4htV2PIE8LA8")
    let visualRecognition = VisualRecognition(version: "2018-03-19", authenticator: authenticator)
    visualRecognition.serviceURL = "https://api.us-south.visual-recognition.watson.cloud.ibm.com/instances/e33cf98c-e21e-4f54-ad1f-47bcad0d85a0"

//   let url = Bundle.main.url(forResource: "fruitbowl", withExtension: "jpg")
//    let fruitbowl = try? Data(contentsOf: url!)
    
    visualRecognition.classify(imagesFile: data, classifierIDs: ["blossom2_167029230"]) {
      response, error in
           //use po error to check what error description you are getting
      guard let result = response?.result else {
        print(error?.localizedDescription ?? "unknown error")
        return
      }

      print(result)
    }
}


//function to resize ui image before upload
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
