//
//  NotePadViewModel.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI
import PencilKit
import Photos

class NotePadViewModel: ObservableObject {
    @Published var selectedTool: DrawingTool = .pencil(.black)
    @Published var selectedColor: Color = .black
    @Published var clearCanvas: Bool = false
    @Published var canvasView: PKCanvasView? = nil
    @Published var showColorPicker = false
    
    var undoManager: UndoManager? {
        return canvasView?.undoManager
    }
    
    func undo() {
        undoManager?.undo()
    }
    
    func redo() {
        undoManager?.redo()
    }
    
    func clear() {
        if let canvas = canvasView {
            canvas.drawing = PKDrawing()
        }
    }
    
    func saveDrawing() {
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


