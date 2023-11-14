//
//  PetCard.swift
//  Mini3
//
//  Created by Júlia Savaris on 06/11/23.
//

import Foundation

import SwiftUI

struct PetCard: View {
    var onClick: () -> Void // Changed from String to closure
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
                    
                    Image(systemName: "ellipsis.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color("Azul"))
                        .padding(.trailing)
                    
                }
                .frame(width: 350)
                
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 210, height: 210)
                        .overlay(
                            Circle()
                                .stroke(PetProfileView.Constants.AzulClaro, lineWidth: 7)
                        )
                    
                    Image(systemName: "pawprint.fill")
                        .font(.system(size: 210 / 2.5, weight: .bold))
                        .foregroundColor(Color(red: 0.8, green: 0.86, blue: 0.92))
                }
                
                
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
