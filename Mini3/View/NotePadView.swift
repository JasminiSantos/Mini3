//
//  NotePadView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI
import PencilKit

struct NotePadView: View {
    @StateObject private var viewModel = NotePadViewModel()
    
    var body: some View {
        VStack {
            if viewModel.showColorPicker {
                CustomColorPicker(selectedColor: $viewModel.selectedColor)
                    .onChange(of: viewModel.selectedColor) { newColor in
                    if case .pencil = viewModel.selectedTool {
                        viewModel.selectedTool = .pencil(newColor)
                    }
                }
                .padding()
            }
            
            UndoRedoToolbar(undoAction: {
                viewModel.canvasView?.undoManager?.undo()
            }, redoAction: {
                viewModel.canvasView?.undoManager?.redo()
            })
        
            DrawingToolbar(selectedTool: $viewModel.selectedTool, selectedColor: $viewModel.selectedColor, showColorPicker: $viewModel.showColorPicker, clearCanvas: $viewModel.clearCanvas)
            
            NotePad(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
                .frame(height: 500)
            
            CustomButton(title: "Save", action: viewModel.saveDrawing, backgroundColor: .blue, textColor: .white)
                .padding()
        }
        .padding()
    }
}
