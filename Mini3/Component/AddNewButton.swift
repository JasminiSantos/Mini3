//
//  AddNewButton.swift
//  Mini3
//
//  Created by Júlia Savaris on 07/11/23.
//

import Foundation
import SwiftUI

struct AddNewButton: View {
    var cor: String
    var title: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(.systemGray5))
                .opacity(0.3)
                .overlay(
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(cor), lineWidth: 3)
                )
                .frame(width: 280, height: 60)
            HStack {
                Image(systemName: "plus")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Azul"))
                
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Azul"))
            }
        }
    }
}

