//
//  FinalView.swift
//  Mini3
//
//  Created by Nicole Cardoso Machado on 08/11/23.
//

import SwiftUI

struct FinalView: View {
    struct Constants {
        static let AzulEscuro: Color = Color(red: 0, green: 0.21, blue:0.35)
        static let AzulClaro: Color = Color(red: 0.42, green: 0.6, blue: 0.77)
        static let Branco: Color = Color(red: 0.94, green: 0.95, blue: 0.95)
        static let Menta: Color = Color(red: 0.45, green: 0.78, blue: 0.62)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Constants.Menta)
            
            VStack (spacing: 30){
                Image(systemName: "list.clipboard")
                    .font(.system(size: 200, weight: .semibold))
                    .foregroundColor(Constants.AzulEscuro)
                
                Text("Finalizado!")
                    .font(.system(size: 70, weight: .bold))
                    .foregroundColor(Constants.AzulEscuro)
                
                Text("Seu prontuário foi salvo e já está pronto para ser compartilhado com seus clientes")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                VStack (spacing: 30){
                    Button(action: {}){
                        HStack(spacing: 20){
                            Image(systemName: "paperplane")
                                .font(.system(size: 32, weight: .medium))
                                .foregroundColor(Constants.AzulEscuro)
                            
                            Text("Compartilhar")
                                .font(.system(size: 32, weight: .bold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Constants.AzulEscuro)
                        }
                    }
                    .foregroundColor(.clear)
                    .frame(width: 350, height: 60)
                    .background(.white)
                    .cornerRadius(18)
                    
                    Button(action: {}){
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
                    .frame(width: 350, height: 60)
                    .background(.white)
                    .cornerRadius(18)
                }
            }
        }
    }
}

#Preview {
    FinalView()
}
