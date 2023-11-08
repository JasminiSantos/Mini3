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
            
            VStack (spacing: 60){
                VStack (spacing: 10){
                    Text("Bem-vindo ao")
                        .font(.system(size: 70, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Image("VetPad")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 500, maxHeight: 70)
                }
                
                VStack (spacing: 20){
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(maxWidth: 730, maxHeight: 200)
                            .background(.white)
                            .cornerRadius(30)
                        
                        HStack(alignment: .center, spacing: 20) {
                            Text("1")
                                .font(.system(size: 130, weight: .heavy))
                                .foregroundColor(Constants.AzulEscuro)
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100, alignment: .center)
                            
                            Text("Preencha seus dados como médico veterinário")
                                .font(.system(size: 32, weight: .semibold))
                                .foregroundColor(Constants.AzulEscuro)
                        }
                        .padding(.horizontal, 80)
                    }
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(maxWidth: 730, maxHeight: 200)
                            .background(.white)
                            .cornerRadius(30)
                        
                        HStack(alignment: .center, spacing: 20) {
                            Text("2")
                                .font(.system(size: 130, weight: .heavy))
                                .foregroundColor(Constants.AzulEscuro)
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100, alignment: .center)
                            
                            Text("Preencha o cadastro básico do seu paciente e seu tutor")
                                .font(.system(size: 32, weight: .semibold))
                                .foregroundColor(Constants.AzulEscuro)
                        }
                        .padding(.horizontal, 80)
                    }
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(maxWidth: 730, maxHeight: 250)
                            .background(.white)
                            .cornerRadius(30)
                        
                        HStack(alignment: .top, spacing: 20) {
                            Text("3")
                                .font(.system(size: 130, weight: .heavy))
                                .foregroundColor(Constants.AzulEscuro)
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100, alignment: .center)
                            
                            VStack (alignment:.leading, spacing: 10) {
                                Text("Faça seu prontuário e compartilhe-o quando estiver preenchido!")
                                    .font(.system(size: 32, weight: .semibold))
                                    .foregroundColor(Constants.AzulEscuro)
                                
                                Text("O prontuário suporta o uso de Apple Pencil e similares, permitindo anotações manuais")
                                    .font(.system(size: 24, weight: .regular))
                                    .foregroundColor(Constants.AzulEscuro)
                            }
                            
                        }
                        
                        .padding(.horizontal, 80)
                    }
                }
                
                HStack {
                    Spacer()
                    
                    Button(action: {}){
                        Text("Próximo")
                            .font(.system(size: 32, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Constants.AzulEscuro)
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Constants.AzulEscuro)
                    }
                    .foregroundColor(.clear)
                    .frame(width: 350, height: 60)
                    .background(.white)
                    .cornerRadius(18)
                    .padding(.top, 30)
                }
                .padding(.horizontal, 50)
            }
            

            
            
        }
        
    }
}

#Preview {
    OnboardingView()
}
