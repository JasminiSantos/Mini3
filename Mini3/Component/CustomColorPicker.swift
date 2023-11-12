//
//  CustomColorPicker.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI

struct CustomColorPicker: View {
    @Binding var selectedTool: DrawingTool
    @Binding var selectedColor: Color
    var orientation: Orientation = .vertical
    var colorAction: () -> Void
    var eraserAction: () -> Void
    
    private let colors: [Color] = [.black, CustomColor.customPaletteBlue, CustomColor.customPaletteGreen, CustomColor.customPaletteYellow, CustomColor.customPaletteRed]
    
    var body: some View {
        Group {
            if orientation == .horizontal {
                HStack { 
                    colorPickerContent
                    eraserButton
                }
            } else {
                VStack { 
                    colorPickerContent
                    eraserButton
                }
            }
        }
        .onChange(of: selectedColor) { newColor in
            selectedTool = .pencil(newColor)
        }
        .onChange(of: selectedTool) { newTool in
            selectedTool = newTool
        }
        .padding(10)
        .background(CustomColor.customGray2)
        .cornerRadius(20)
    }
    
    var colorPickerContent: some View {
        ForEach(colors, id: \.self) { color in
            Button(action: {
                colorAction()
            }) {
                Circle()
                    .fill(color)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Circle()
                            .stroke(selectedColor == color ? Color.white : Color.clear, lineWidth: 2)
                    )
                    .onTapGesture {
                        selectedColor = color
                        selectedTool = .pencil(selectedColor)
                    }
            }
        }
    }
    var eraserButton: some View {
            Button(action: {
                eraserAction()
            }) {
                ZStack {
                    Circle()
                        .fill(.white)
                        .stroke(Color.black, lineWidth: 1)
                        .frame(width: 30, height: 30)
                    Circle()
                        .fill(selectedColor == nil ? Color.white : Color.clear)
                        .frame(width: 30, height: 30)
                    Image(systemName: "eraser")
                        .foregroundColor(.black)
                        .frame(width: 30, height: 30)
                    
                }
            }
    }
}

enum Orientation {
    case horizontal
    case vertical
}
