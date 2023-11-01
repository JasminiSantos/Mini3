//
//  CustomButton.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void
    var backgroundColor: Color
    var textColor: Color
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(textColor)
                .padding()
                .frame(width: 200, height: 55)
                .background(backgroundColor)
                .cornerRadius(16)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

