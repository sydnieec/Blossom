//
//  DiagnosisResultView.swift
//  Blossom
//
//  Created by Sydnie Chau on 2020-07-27.
//  Copyright © 2020 Sydnie Chau. All rights reserved.
//

import SwiftUI

struct DiagnosisResultView: View {
    @Binding var identified : String
    var body: some View {
        Text(identified)
    }
}

struct DiagnosisResultView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisResultView(identified: .constant("Asd"))
    }
}
