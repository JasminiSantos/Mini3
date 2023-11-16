//
//  ErrorView.swift
//  Mini3
//
//  Created by Nicole Cardoso Machado on 08/11/23.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var viewModel: MedicalRecordViewModel
    @Environment(\.dismiss) var dismiss
    
    struct Constants {
        static let AzulEscuro: Color = Color(red: 0, green: 0.21, blue:0.35)
        static let AzulClaro: Color = Color(red: 0.42, green: 0.6, blue: 0.77)
        static let Branco: Color = Color(red: 0.94, green: 0.95, blue: 0.95)
        static let Menta: Color = Color(red: 0.45, green: 0.78, blue: 0.62)
        static let VermelhoAlaranjado: Color = Color(red: 0.91, green: 0.44, blue: 0.32)
        }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Constants.VermelhoAlaranjado)
            
            VStack (spacing: 30){
                Image(systemName: "x.circle")
                    .font(.system(size: 200, weight: .semibold))
                    .foregroundColor(Constants.AzulEscuro)
                
                Text("Ah não!")
                    .font(.system(size: 70, weight: .bold))
                    .foregroundColor(Constants.AzulEscuro)
                
                Text("Identificamos um erro ao finalizar o seu prontuário, revise-o ou tente novamente mais tarde :(")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                VStack (spacing: 30){
                    Button(action: {
                        viewModel.submissionState = .none
                    }){
                        HStack(spacing: 20){
                            Image(systemName: "paperplane")
                                .font(.system(size: 32, weight: .medium))
                                .foregroundColor(Constants.AzulEscuro)
                            
                            Text("Voltar ao prontuário")
                                .font(.system(size: 32, weight: .bold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Constants.AzulEscuro)
                        }
                    }
                    .foregroundColor(.clear)
                    .frame(width: 430, height: 60)
                    .background(.white)
                    .cornerRadius(18)
                    
                    
                    Button(action: {
                        dismiss()
                    }){
                        HStack(spacing: 20){
                            Image(systemName: "house")
                                .font(.system(size: 32, weight: .medium))
                                .foregroundColor(Constants.AzulEscuro)
                            
                            Text("Ir para o início")
                                .font(.system(size: 32, weight: .bold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Constants.AzulEscuro)
                        }
                    }
                    .foregroundColor(.clear)
                    .frame(width: 430, height: 60)
                    .background(.white)
                    .cornerRadius(18)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
