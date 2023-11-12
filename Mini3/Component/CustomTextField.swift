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
    var backgroundColor: Color
    var borderColor: Color
    var onCommit: () -> Void
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor)
                .frame(height: 60)
            
            RoundedRectangle(cornerRadius: 20)
                .stroke(borderColor, lineWidth: 1)
                .frame(height: 60)
            
            TextField(placeholder, text: $text, onCommit: onCommit)
                .font(.system(size: 24, weight: .regular))
                .padding(.horizontal,20)
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
    }
    
}
