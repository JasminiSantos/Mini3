//
//  SearchBar.swift
//  Mini3
//
//  Created by Júlia Savaris on 07/11/23.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    var onCommit: () -> Void = {}
    var action: () -> Void = {}
    var cor: String
    
    var body: some View {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(.systemGray5))
                    .opacity(0.3)
                    .overlay(
                        
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(cor), lineWidth: 3)
                    )
                    .frame(width: 350, height: 60)
                
                HStack{
                    TextField(placeholder, text: $text, onCommit: onCommit)
                        .padding(.horizontal)
                    
                    Button(action: {
                        print("search")
                    }
                           , label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(cor))
                            .font(.title)
                            .bold()
                            .padding(.trailing)
                    })
                }
                
                .frame(width: 350, height: 60)


        }
        .onChange(of: text) { _ in
            action()
        }
             
    }
        
    
}
