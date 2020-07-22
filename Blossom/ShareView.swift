//
//  ShareView.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-07-22.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//

import SwiftUI

struct ShareView: View {
    var body: some View {
        Text("share view")
            .font(.title)
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
        .previewDevice(PreviewDevice(rawValue: "iPhone XR"))

    }
}
