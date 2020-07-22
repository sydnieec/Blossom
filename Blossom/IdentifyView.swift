//
//  IdentifyView.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-07-22.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//

import SwiftUI

struct IdentifyView: View {
    var body: some View {
        Text("identify view")
            .font(.title)
    }
}

struct IdentifyView_Previews: PreviewProvider {
    static var previews: some View {
        IdentifyView()
        .previewDevice(PreviewDevice(rawValue: "iPhone XR"))

    }
}
