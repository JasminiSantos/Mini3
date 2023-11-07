//
//  PetProfileView.swift
//  Mini3
//
//  Created by Nicole Cardoso Machado on 02/11/23.
//

import SwiftUI

struct PetProfileView: View {
    struct Constants {
      static let AzulEscuro: Color = Color(red: 0, green: 0.21, blue:0.35)
      static let AzulClaro: Color = Color(red: 0.42, green: 0.6, blue: 0.77)
      static let Branco: Color = Color(red: 0.94, green: 0.95, blue: 0.95)

    }
    @State private var nome = ""
    @State private var idade = ""
    @State private var raca = ""
    @State private var pelagem = ""
    
    var body: some View {
        ZStack {
            //retângulo de fundo
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: 730, maxHeight: 630)
                .background(Color(red: 0.88, green: 0.92, blue: 0.95))
                .cornerRadius(30)
            
            VStack {
                HStack {
                    //DADOS DA DIREITA
                    VStack (alignment: .leading, spacing: 8){
                        Text("Dados do Pet")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Constants.AzulEscuro)
                            .padding(.bottom, 25)
                        
                        Text("Nome do animal:")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.black)
                        
                        TextField("", text: $nome)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(Constants.AzulEscuro)
                            .frame(width: 300, height: 50)
                            .background(.white)
                            .cornerRadius(14)
                            .overlay(RoundedRectangle(cornerRadius: 14).inset(by: 0.5).stroke(Constants.AzulClaro, lineWidth: 1))
                        
                        
                        Text("Idade:")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.black)
                        
                        TextField("", text: $idade)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(Constants.AzulEscuro)
                            .frame(width: 300, height: 50)
                            .background(.white)
                            .cornerRadius(14)
                            .overlay(RoundedRectangle(cornerRadius: 14).inset(by: 0.5).stroke(Constants.AzulClaro, lineWidth: 1))
                        
                        Text("Espécie:")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.black)
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 250, height: 50)
                            .background(Color(red: 0.42, green: 0.6, blue: 0.77).opacity(0.35))
                            .background(.white)
                            .cornerRadius(14)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .inset(by: 0.5)
                                    .stroke(Constants.AzulClaro, lineWidth: 1)
                            )
                        
                        Text("Raça:")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.black)
                        
                        TextField("", text: $raca)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(Constants.AzulEscuro)
                            .frame(width: 300, height: 50)
                            .background(.white)
                            .cornerRadius(14)
                            .overlay(RoundedRectangle(cornerRadius: 14).inset(by: 0.5).stroke(Constants.AzulClaro, lineWidth: 1))
                        
                    }//FIM DA VSTACK
                    
                    VStack (alignment: .leading, spacing: 8){
                        HStack (alignment: .top) {
                            ZStack{
                                //BOTÃO DE ADD IMAGEM
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 170, height: 170)
                                    .background(.white)
                                    .cornerRadius(360)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 360)
                                            .inset(by: -7)
                                            .stroke(Constants.AzulClaro, lineWidth: 7)
                                    )
                                
                                Image(systemName: "pawprint.fill")
                                    .font(.system(size: 70, weight: .bold))
                                    .foregroundColor(Color(red: 0.8, green: 0.86, blue: 0.92))
                                
                                Button(action: {}) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundColor(Constants.Branco)
                                        .frame(width: 60, height: 60)
                                        .background(Constants.AzulClaro)
                                        .cornerRadius(360)
                                }
                                .padding(.top, 130)
                                .padding(.trailing, 100)
                            }
                            .padding(.bottom, 60)
                            .padding(.leading, 60)
                            
                            //BOTÃO DE EDIÇÃO
//                            Button(action: {}) {
//                                Image(systemName: "square.and.pencil")
//                                    .font(.system(size: 28, weight: .bold))
//                                    .foregroundColor(Constants.Branco)
//                                    .frame(width: 50, height: 50)
//                                    .background(Constants.AzulEscuro)
//                                    .cornerRadius(360)
//                            }
                        }
                        
                        Text("Sexo: ")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.black)
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 250, height: 50)
                            .background(Color(red: 0.42, green: 0.6, blue: 0.77).opacity(0.35))
                            .background(.white)
                            .cornerRadius(14)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .inset(by: 0.5)
                                    .stroke(Constants.AzulClaro, lineWidth: 1)
                            )
                        
                        Text("Pelagem:")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.black)
                        
                        TextField("", text: $pelagem)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(Constants.AzulEscuro)
                            .frame(width: 300, height: 50)
                            .background(.white)
                            .cornerRadius(14)
                            .overlay(RoundedRectangle(cornerRadius: 14).inset(by: 0.5).stroke(Constants.AzulClaro, lineWidth: 1))
                        
                        
                    }//FIM DA VSTACK
                    .padding(.leading, 30)
                    
                    
                }
                //BOTÃO DE SALVAR ALTERAÇÕES
//                Button(action: {}){
//                    Image(systemName: "checkmark")
//                        .font(.system(size: 32, weight: .bold))
//                        .foregroundColor(Constants.Branco)
//                    
//                    Text("Salvar alterações")
//                        .font(.system(size: 32, weight: .bold))
//                        .multilineTextAlignment(.center)
//                        .foregroundColor(Constants.Branco)
//                }
//                .foregroundColor(.clear)
//                .frame(width: 350, height: 60)
//                .background(Constants.AzulClaro)
//                .cornerRadius(18)
//                .padding(.top, 30)
                
                Image(systemName: "pawprint.fill")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Constants.AzulClaro)
                    .padding(.top, 30)
                
            }//FIM DA VSTACK
            
            
        }//FIM DA ZSTACK
        .background(.clear)
        .ignoresSafeArea(.all)
    }
    
}


#Preview {
    PetProfileView()
}
