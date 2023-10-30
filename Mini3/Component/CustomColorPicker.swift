//
//  CustomColorPicker.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI

struct CustomColorPicker: View {
    @Binding var selectedColor: Color
    
    private let colors: [Color] = [.black, .red, .green, .blue, .orange, .pink, .purple, .yellow, .gray]
    
    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
                Circle()
                    .fill(color)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Circle()
                            .stroke(selectedColor == color ? Color.black : Color.clear, lineWidth: 2)
                    )
                    .onTapGesture {
                        selectedColor = color
                    }
            }
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}


struct ColorItem: Identifiable {
    let id: UUID = UUID()
    let color: Color
}
