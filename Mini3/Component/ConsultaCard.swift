//
//  ConsultaCard.swift
//  Mini3
//
//  Created by Júlia Savaris on 06/11/23.
//

import Foundation
import SwiftUI

struct ConsultaCard: View {
    var onClick: String
    var onCommit: () -> Void
    var nomePet: String
    var nomeTutor: String
    var data: String
    var hora: String

    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color("Amarelo"))
                .frame(width: 350, height: 200)
                .cornerRadius(30)
                .opacity(0.3)
            
            VStack(alignment: .leading) {
                HStack{
                    
                    
                    Image(systemName: "calendar")
                        .font(.title3)
                        .foregroundColor(Color("Azul"))
                        .padding(.leading)
                    
                    Text(data)
                        .font(.title2)
                        .foregroundColor(Color("Azul"))
                    
                    Text("|")
                        .font(.title2)
                        .foregroundColor(Color("Azul"))
                    
                    Text(hora)
                        .font(.title2)
                        .foregroundColor(Color("Azul"))
                    
                    
                    
                    Spacer()
                    
                    Button {
                        print("ir para o prontuário pronto")
                        
                    } label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color("Azul"))
                            .padding(.trailing)
                    }

                    
                }
                .frame(width: 350)
                
                Text(nomePet)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Azul"))
                        .padding(.vertical, 2)
                        .padding(.leading)
                
                Text(nomeTutor)
                        .font(.title2)
                        .foregroundColor(Color("Azul"))
                        .padding(.bottom, 2)
                        .padding(.leading)
                
                    
            }
        }
    }
}
