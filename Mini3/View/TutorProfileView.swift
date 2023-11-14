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
    
    @ObservedObject var viewModel: PetProfileViewModel
    
    var body: some View {
        ZStack {
            //retângulo de fundo
            Rectangle()
                .foregroundColor(.clear)
                .background(.white)
                .overlay(RoundedRectangle(cornerRadius: 30).inset(by: 0.5).stroke(Constants.AzulClaro, lineWidth: 1))
                .cornerRadius(30)
            
            VStack {
                
                    //DADOS DA DIREITA
                    VStack (alignment: .leading, spacing: 20){
                        HStack {
                            Text("Dados do Tutor")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(Constants.AzulEscuro)
                            .padding(.bottom, 25)
                            
                            //BOTÃO DE EDIÇÃO
                            if viewModel.currentState == .editing {
                                Spacer()
                                
                                Image(systemName: "square.and.pencil")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(Constants.Branco)
                                    .frame(width: 50, height: 50)
                                    .background(Constants.AzulEscuro)
                                    .cornerRadius(360)
                            }

                        }
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("Nome do Tutor:")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(.black)
                                
                                CustomTextField(text: $viewModel.petOwner.name, placeholder: "", backgroundColor: Color(red: 0.88, green: 0.92, blue: 0.95), borderColor: Constants.AzulClaro, onCommit: {
                                    
                                })
                            }
                            
                            HStack (spacing: 30){
                                VStack (alignment: .leading){
                                    Text("CPF:")
                                        .font(.system(size: 24, weight: .medium))
                                        .foregroundColor(.black)
                                    
                                    
                                    CustomTextField(text: $viewModel.petOwner.cpf, placeholder: "", backgroundColor: Color(red: 0.88, green: 0.92, blue: 0.95), borderColor: Constants.AzulClaro, onCommit: {
                                        
                                    })
                                }
                                VStack (alignment: .leading){
                                    Text("Telefone:")
                                        .font(.system(size: 24, weight: .medium))
                                        .foregroundColor(.black)
                                    
                                    
                                    CustomTextField(text: $viewModel.petOwner.phoneNumber, placeholder: "", backgroundColor: Color(red: 0.88, green: 0.92, blue: 0.95), borderColor: Constants.AzulClaro, onCommit: {
                                        
                                    })
                                }
                            }
                            .padding(.bottom, 10)
                            VStack(alignment: .leading) {
                                Text("Endereço:")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(.black)
                                
                                CustomTextField(text: $viewModel.petOwner.address, placeholder: "", backgroundColor: Color(red: 0.88, green: 0.92, blue: 0.95), borderColor: Constants.AzulClaro, onCommit: {
                                    
                                })
                            }
                            .padding(.bottom, 10)
                            VStack(alignment: .leading) {
                                Text("E-mail:")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(.black)
                                
                                CustomTextField(text: $viewModel.petOwner.email, placeholder: "", backgroundColor: Color(red: 0.88, green: 0.92, blue: 0.95), borderColor: Constants.AzulClaro, onCommit: {
                                    
                                })
                            }
                        }
                        
                    }//FIM DA VSTACK
                    
                //BOTÃO DE SALVAR ALTERAÇÕES
                if viewModel.currentState == .editing {
                    Button(action: {
                        viewModel.updatePetOwner()
                    }){
                        Image(systemName: "checkmark")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Constants.Branco)

                        Text("Salvar alterações")
                            .font(.system(size: 32, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Constants.Branco)
                    }
                    .foregroundColor(.clear)
                    .frame(width: 350, height: 60)
                    .background(Constants.AzulClaro)
                    .cornerRadius(18)
                    .padding(.top, 30)
                }
                Image(systemName: "person.fill")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Constants.AzulClaro)
                    .padding(.vertical, 30)
                
            }//FIM DA VSTACK
            .padding(40)
            
        }//FIM DA ZSTACK
        .background(.clear)
        .ignoresSafeArea(.all)
    
    }
}
