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
    var body: some View {
        Text("Diagnosis View")
            .font(.title)
    }
}

struct DiagnosisView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisView()
        .previewDevice(PreviewDevice(rawValue: "iPhone XR"))

    }
}
