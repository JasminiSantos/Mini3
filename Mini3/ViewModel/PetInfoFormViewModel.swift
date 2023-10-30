//
//  PetInfoFormViewModel.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 30/10/23.
//

import Foundation
import PDFKit
import UIKit

class PetInfoFormViewModel: ObservableObject {
    @Published var petName = ""
    @Published var petType = ""
    @Published var petAge = ""
    @Published var ownerName = ""
    @Published var additionalInfo = ""
    
    func saveAsPDF() {
        let pdfData = generatePDF()
        let pdfDocument = PDFDocument(data: pdfData)
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let pdfPath = documentsPath.appendingPathComponent("PetInfo.pdf")
        
        do {
            try pdfDocument?.dataRepresentation()?.write(to: pdfPath)
            print("PDF Saved to \(pdfPath)")
        } catch {
            print("Error saving PDF: \(error.localizedDescription)")
        }
    }
    
    func generatePDF() -> Data {
        let pdfMetaData = [
            kCGPDFContextTitle: "Pet Information",
            kCGPDFContextAuthor: "Pet App",
            kCGPDFContextCreator: "Pet App"
        ] as [String: Any]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData
        
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        let pdfData = renderer.pdfData { context in
            context.beginPage()
            let attributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
            ]
            let text = """
            Pet Name: \(petName)
            Pet Type: \(petType)
            Pet Age: \(petAge)
            Owner's Name: \(ownerName)
            Additional Information: \(additionalInfo)
            """
            text.draw(at: CGPoint(x: 72, y: 72), withAttributes: attributes)
        }
        
        return pdfData
    }
}

