//
//  NotePadViewModel.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI
import PencilKit
import Photos

@MainActor
class NotePadViewModel: ObservableObject {
    @Published var selectedTool: DrawingTool = .pencil(.black)
    @Published var selectedColor: Color = .black
    @Published var clearCanvas: Bool = false
    @Published var canvasView: PKCanvasView? = nil
    
    @Published var canvasDrawings: [PKDrawing] = []
    @Published var canvasImages: [UIImage?] = []
    @Published var currentIndex = 0
    @Published var lineType: lineType = .none
    
    init(lineType: lineType = .none) {
        self.lineType = lineType
    }
    
    init(currentIndex: Int){
        self.currentIndex = currentIndex
        self.selectCanvas(at: currentIndex)
    }
    
    func selectCanvas(at index: Int) {
        canvasDrawings[currentIndex] = canvasView!.drawing
        currentIndex = index - 1

        guard canvasDrawings.indices.contains(currentIndex) else {
            return
        }

        canvasView?.drawing = canvasDrawings[currentIndex]
    }
    
    func saveDrawing(){
        if let drawing = canvasView?.drawing {
            canvasDrawings[currentIndex] = drawing
        }
    }
    
    func initializeCanvasDrawings(count: Int) {
        canvasDrawings = (0..<count).map { _ in PKDrawing() }    }

    var undoManager: UndoManager? {
        return canvasView?.undoManager
    }
    
    func undo() {
        print("exists 1: \(canvasView != nil)")
        undoManager?.undo()
    }
    
    func redo() {
        print("exists 2: \(canvasView != nil)")
        undoManager?.redo()
    }
    
    func clear() {
        if let canvas = canvasView {
            canvas.drawing = PKDrawing()
        }
    }
    
    func saveDrawingToAlbum() {
        checkPhotoLibraryPermission { [weak self] hasPermission in
            guard hasPermission else {
                print("Photo library access denied")
                return
            }
            
            guard let self = self, let canvasView = self.canvasView else { return }
            
            let image = canvasView.drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
            self.saveImageToAlbum(image)
        }
    }
    
    func getImages() {
        guard let canvasView = self.canvasView else {
            print("CanvasView is not initialized")
            return
        }

        for drawing in self.canvasDrawings {
            let image = drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
            self.canvasImages.append(image)
        }
    }
    
    func getImage(at index: Int)-> UIImage? {
        guard let canvasView = self.canvasView else {
            print("CanvasView is not initialized")
            return nil
        }
        return self.canvasDrawings[index-1].image(from: canvasView.bounds, scale: UIScreen.main.scale)
    }
    
    func saveAllDrawingsToAlbum() {
        checkPhotoLibraryPermission { [weak self] hasPermission in
            guard hasPermission else {
                print("Photo library access denied")
                return
            }
            
            guard let self = self else { return }
            
            guard let canvasView = self.canvasView else {
                print("CanvasView is not initialized")
                return
            }

            for drawing in self.canvasDrawings {
                let image = drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
                self.saveImageToAlbum(image)
            }
        }
    }
    
    func saveImageToAlbum(_ image: UIImage) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }, completionHandler: { (success, error) in
            if let error = error {
                print("Error saving image: \(error.localizedDescription)")
            } else if success {
                print("Image saved successfully!")
            }
        })
    }

    func checkPhotoLibraryPermission(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized, .limited:
            completion(true)
        case .denied, .restricted:
            completion(false)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    completion(newStatus == .authorized || newStatus == .limited)
                }
            }
        @unknown default:
            completion(false)
        }
    }
}

enum lineType {
    case normal
    case dotted
    case none
}
