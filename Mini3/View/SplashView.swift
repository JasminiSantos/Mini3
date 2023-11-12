//
//  SplashView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 08/11/23.
//

import SwiftUI

struct SplashView: View {

    var body: some View {
        VStack {
            Image("VetPad")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400)
        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(CustomColor.customDarkBlue)
    }
}
