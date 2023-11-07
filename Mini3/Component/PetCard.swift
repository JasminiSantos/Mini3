//
//  PetCard.swift
//  Mini3
//
//  Created by Júlia Savaris on 06/11/23.
//

import Foundation

import SwiftUI

struct PetCard: View {
    var onClick: String
    var onCommit: () -> Void
    var nomePet: String
    var nomeTutor: String
    var especie: String
    
    var body: some View {
        
       
        ZStack{
            
            Rectangle()
                .foregroundColor(Color("AzulClaro"))
                .frame(width: 350, height: 450)
                .cornerRadius(30)
                .opacity(0.3)
            
            VStack(alignment: .center) {
                
                HStack(alignment: .top) {
                    Spacer()
                    
                    Button {
                        print("ir para perfil do Pet")
                        
                    } label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color("Azul"))
                            .padding(.trailing)
                    }
                    
                }
                .frame(width: 350)
                
                Circle()
                            .frame(width: 210, height: 210) // Adjust the size of the circle
                            .foregroundColor(.blue) // Change the fill color of the circle
                            .overlay(
                                Circle()
                                    .stroke(Color("AzulClaro"), lineWidth: 7) // Adjust the border color and width
                            )
                
                            .padding(.bottom)
                
                
                Text(nomePet)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Azul"))
                
                Text("Tutor: \(nomeTutor)")
                    .font(.title2)
                    .foregroundColor(Color("Azul"))
                    .padding(.bottom, 2)

                
                Text(especie)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Azul"))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 30)
                    .background(Color("Amarelo"))
                    .cornerRadius(10)
                
                
            }
        }

    }
}
