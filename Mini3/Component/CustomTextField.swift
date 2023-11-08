//
//  CustomTextField.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var onCommit: () -> Void
    var backgroundColor: Color
    var borderColor: Color
    
    var body: some View {
        
        ZStack {
            // White background
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(height: 60) // Adjust the height as needed
            
            // Mint border
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("Menta"), lineWidth: 2)
                .frame(height: 60) // Should match the height of the background
            
            TextField(placeholder, text: $text, onCommit: onCommit)
                .padding(.horizontal,20)
        }
    }
}
