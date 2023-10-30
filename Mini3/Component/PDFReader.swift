//
//  PDFReader.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI
import PDFKit


struct PDFReader: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        loadPDF(pdfView)
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {}
    
    func loadPDF(_ pdfView: PDFView) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let document = PDFDocument(data: data) {
                DispatchQueue.main.async {
                    pdfView.document = document
                }
            } else {
                print("Failed to load PDF: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        task.resume()
    }
}
