//
//  DrawingToolBar.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI
import PencilKit

struct DrawingToolbar: View {
    @Binding var selectedTool: DrawingTool
    @Binding var selectedColor: Color
    @Binding var showColorPicker: Bool
    @Binding var clearCanvas: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                selectedTool = .pencil(selectedColor)
            }) {
                Image(systemName: "pencil")
            }
            
            Button(action: {
                selectedTool = .eraser
            }) {
                Image(systemName: "eraser")
            }
            
            Button(action: {
                showColorPicker.toggle()
            }) {
                Image(systemName: "paintpalette")
            }
            
            Button(action: {
                clearCanvas = true
            }) {
                Image(systemName: "trash")
            }
        }
        .padding()
        .background(Color.white.opacity(0.7))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
