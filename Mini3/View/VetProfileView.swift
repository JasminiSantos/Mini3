//
//  VetProfileView.swift
//  Mini3
//
//  Created by Júlia Savaris on 31/10/23.
//

import SwiftUI

struct VetProfileView: View {
    @State var text: String = ""
    
    var body: some View {
        VStack{
            Text("Criar seu perfil")
                .fontWeight(.semibold)
                .font(.largeTitle)
                .padding(.vertical)
            VStack{
                
                VStack (alignment: .leading) {
                    Text("Dados do Médico Veterinário")
                        .fontWeight(.semibold)
                        .font(.title)
                        .padding(.vertical)
                    
                    Text("Nome completo:")
                        .font(.title2)
                    
                    CustomTextField(text: $text, placeholder: "", onCommit: {
                        
                    })
                    .padding(.bottom)
                    HStack{
                        VStack(alignment: .leading){
                            Text("CRMV:")
                                .font(.title2)
                            CustomTextField(text: $text, placeholder: "", onCommit: {
                                
                            })
                        }
                        
                        .padding(.trailing)
                        VStack(alignment: .leading) {
                            Text("Telefone:")
                                .font(.title2)
                            CustomTextField(text: $text, placeholder: "", onCommit: {
                                
                            })
                            
                        }
                    }
                    .padding(.bottom)
                    
                    
                    Text("E-mail:")
                        .font(.title2)
                    
                    CustomTextField(text: $text, placeholder: "", onCommit: {
                        
                    })
                    .padding(.bottom)
                    
                    Text("CPF")
                        .font(.title2)
                    
                    CustomTextField(text: $text, placeholder: "", onCommit: {
                        
                    })
                    .padding(.bottom)
                    
                    Text("Sua assinatura:")
                        .font(.title2)
                    CustomTextField(text: $text, placeholder: "", onCommit: {
                        
                    }) // trocar pelo espaço de desenho
                    
                    .padding(.bottom)
                    
                    HStack{
                        Spacer()
                        Image(systemName: "stethoscope")
                            .font(.title)
                            .foregroundColor(Color("Menta"))
                        Spacer()
                        
                    }
                    .padding(.vertical)
                }
                .padding(30)
                
                
            }
            .background(
                Color("Menta")
                    .opacity(0.2)
                    .cornerRadius(29)
            )
        }
        .padding(70)
        HStack{
            Spacer()
//            CustomButton(title: "Próximo", action: {}, backgroundColor: Color("Menta"), textColor: Color("Azul"))
        }
        .padding(.horizontal, 70)
    }
}

#Preview {
    PetProfileView()
}
