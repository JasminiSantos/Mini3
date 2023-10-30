//
//  NotePad.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI
import PencilKit

struct NotePad: UIViewRepresentable {
    @ObservedObject var viewModel: NotePadViewModel
    
    func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView()
        canvas.delegate = context.coordinator
        canvas.tool = PKInkingTool(.pen, color: UIColor(viewModel.selectedColor), width: 5)
        canvas.allowsFingerDrawing = true
        viewModel.canvasView = canvas
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if viewModel.clearCanvas {
            uiView.drawing = PKDrawing()
            DispatchQueue.main.async {
                viewModel.clearCanvas = false
            }
        }
        switch viewModel.selectedTool {
        case .pencil(let color):
            uiView.tool = PKInkingTool(.pen, color: UIColor(color), width: 5)
        case .eraser:
            uiView.tool = PKEraserTool(.bitmap)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: NotePad
        
        init(_ parent: NotePad) {
            self.parent = parent
        }
    }
}



