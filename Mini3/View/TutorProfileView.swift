//
//  TutorProfileView.swift
//  Mini3
//
//  Created by Nicole Cardoso Machado on 03/11/23.
//

import SwiftUI

struct TutorProfileView: View {
    struct Constants {
      static let AzulEscuro: Color = Color(red: 0, green: 0.21, blue:0.35)
      static let AzulClaro: Color = Color(red: 0.42, green: 0.6, blue: 0.77)
      static let Branco: Color = Color(red: 0.94, green: 0.95, blue: 0.95)

    }
    @State private var nomeTutor = ""
    @State private var cpf = ""
    @State private var telefone = ""
    @State private var endereco = ""
    @State private var email = ""
    
    var body: some View {
        ZStack {
            //retângulo de fundo
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: 730, maxHeight: 650)
                .background(.white)
                .overlay(RoundedRectangle(cornerRadius: 30).inset(by: 0.5).stroke(Constants.AzulClaro, lineWidth: 1))
                .cornerRadius(30)
            
            VStack {
                
                    //DADOS DA DIREITA
                    VStack (alignment: .leading, spacing: 8){
                        HStack {
                            Text("Dados do Tutor")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(Constants.AzulEscuro)
                            .padding(.bottom, 25)
                            
                            //BOTÃO DE EDIÇÃO
//                            Spacer()
//                            
//                            Button(action: {}) {
//                                Image(systemName: "square.and.pencil")
//                                    .font(.system(size: 28, weight: .bold))
//                                    .foregroundColor(Constants.Branco)
//                                    .frame(width: 50, height: 50)
//                                    .background(Constants.AzulEscuro)
//                                    .cornerRadius(360)
//                            }

                        }
                        
                        Text("Nome do Tutor:")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.black)
                        
                        TextField("", text: $nomeTutor)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(Constants.AzulEscuro)
                            .frame(width: .infinity, height: 50)
                            .background(Color(red: 0.88, green: 0.92, blue: 0.95))
                            .cornerRadius(14)
                            .overlay(RoundedRectangle(cornerRadius: 14).inset(by: 0.5).stroke(Constants.AzulClaro, lineWidth: 1))
                        
                        
                        HStack (spacing: 30){
                            VStack (alignment: .leading){
                                Text("CPF:")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(.black)
                                
                                
                                TextField("", text: $cpf)
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(Constants.AzulEscuro)
                                    .frame(width: .infinity, height: 50)
                                    .background(Color(red: 0.88, green: 0.92, blue: 0.95))
                                    .cornerRadius(14)
                                    .overlay(RoundedRectangle(cornerRadius: 14).inset(by: 0.5).stroke(Constants.AzulClaro, lineWidth: 1))
                            }
                            VStack (alignment: .leading){
                                Text("Telefone:")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(.black)
                                
                                
                                TextField("", text: $telefone)
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(Constants.AzulEscuro)
                                    .frame(width: .infinity, height: 50)
                                    .background(Color(red: 0.88, green: 0.92, blue: 0.95))
                                    .cornerRadius(14)
                                    .overlay(RoundedRectangle(cornerRadius: 14).inset(by: 0.5).stroke(Constants.AzulClaro, lineWidth: 1))
                            }
                        }
                        .padding(.vertical, 15)
                        
                        Text("Endereço:")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.black)
                        
                        TextField("", text: $endereco)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(Constants.AzulEscuro)
                            .frame(width: .infinity, height: 50)
                            .background(Color(red: 0.88, green: 0.92, blue: 0.95))
                            .cornerRadius(14)
                            .overlay(RoundedRectangle(cornerRadius: 14).inset(by: 0.5).stroke(Constants.AzulClaro, lineWidth: 1))
                        
                        Text("E-mail:")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.black)
                        
                        TextField("", text: $email)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(Constants.AzulEscuro)
                            .frame(width: .infinity, height: 50)
                            .background(Color(red: 0.88, green: 0.92, blue: 0.95))
                            .cornerRadius(14)
                            .overlay(RoundedRectangle(cornerRadius: 14).inset(by: 0.5).stroke(Constants.AzulClaro, lineWidth: 1))
                        
                    }//FIM DA VSTACK
                    
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
                
                Image(systemName: "person.fill")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Constants.AzulClaro)
                    .padding(.top, 30)
                
            }//FIM DA VSTACK
            .padding(100)
            
        }//FIM DA ZSTACK
        .background(.clear)
        .ignoresSafeArea(.all)
    
    }
}

#Preview {
    TutorProfileView()
}
