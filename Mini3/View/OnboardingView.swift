//
//  OnboardingView.swift
//  Mini3
//
//  Created by Nicole Cardoso Machado on 06/11/23.
//

import SwiftUI

struct OnboardingView: View {
    struct Constants {
      static let AzulEscuro: Color = Color(red: 0, green: 0.21, blue:0.35)
      static let AzulClaro: Color = Color(red: 0.42, green: 0.6, blue: 0.77)
      static let Branco: Color = Color(red: 0.94, green: 0.95, blue: 0.95)

    }
    
    var body: some View {

        
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Constants.AzulClaro)
            
            Text("Bem-vindo ao")
                .font(.system(size: 50, weight: .semibold))
                .foregroundColor(.white)
            
            Image("VetPad")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
        }
        
    }
}

#Preview {
    OnboardingView()
}
