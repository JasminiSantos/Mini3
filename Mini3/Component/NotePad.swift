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
    
    func makeUIView(context: Context) -> UIView {
        let container = UIView(frame: .zero)
        var linedBackground: UIView? = nil
        
        if viewModel.lineType == .dotted {
            linedBackground = DottedLineBackgroundView()
        }
        else if viewModel.lineType == .normal {
            linedBackground = LineBackgroundView()
        }
        if let linedBackground = linedBackground{
            linedBackground.backgroundColor = .clear
            linedBackground.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(linedBackground)
            
            NSLayoutConstraint.activate([
                linedBackground.topAnchor.constraint(equalTo: container.topAnchor),
                linedBackground.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                linedBackground.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                linedBackground.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            ])
        }
        let canvas = PKCanvasView()
        canvas.backgroundColor = .clear
        canvas.delegate = context.coordinator
        canvas.tool = PKInkingTool(.pen, color: UIColor(viewModel.selectedColor), width: 5)
//        canvas.allowsFingerDrawing = true
        canvas.drawingPolicy = .anyInput
        viewModel.canvasView = canvas
        canvas.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(canvas)
        
        NSLayoutConstraint.activate([
            canvas.topAnchor.constraint(equalTo: container.topAnchor),
            canvas.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            canvas.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            canvas.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        ])
        
        return container
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let canvasView = viewModel.canvasView else { return }
        
        if viewModel.clearCanvas {
            canvasView.drawing = PKDrawing()
            DispatchQueue.main.async {
                viewModel.clearCanvas = false
            }
        }
        
        switch viewModel.selectedTool {
            case .pencil(let color):
                canvasView.tool = PKInkingTool(.pen, color: UIColor(color), width: 5)
            case .eraser:
                canvasView.tool = PKEraserTool(.bitmap)
        }
        canvasView.drawing = viewModel.canvasView!.drawing
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
class LineBackgroundView: UIView {

    var lineSpacing: CGFloat = 45
    var linePadding: CGFloat = 20

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setLineWidth(1)
        context.setStrokeColor(UIColor.gray.cgColor)

        var startY: CGFloat = 0
        while startY < rect.height {
            context.move(to: CGPoint(x: linePadding, y: startY))
            context.addLine(to: CGPoint(x: rect.width - linePadding, y: startY))
            context.strokePath()
            startY += lineSpacing
        }
    }
}


class DottedLineBackgroundView: UIView {
    
    var lineSpacing: CGFloat = 40
    var linePadding: CGFloat = 20
    var dotSpacing: CGFloat = 5

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setLineWidth(1)
        context.setStrokeColor(UIColor.gray.cgColor)
        
        let dashPattern: [CGFloat] = [3, dotSpacing]

        var startY: CGFloat = lineSpacing
        while startY < rect.height {
            context.setLineDash(phase: 0, lengths: dashPattern)
            context.move(to: CGPoint(x: linePadding, y: startY))
            context.addLine(to: CGPoint(x: rect.width - linePadding, y: startY))
            context.strokePath()
            startY += lineSpacing
        }
    }
}
