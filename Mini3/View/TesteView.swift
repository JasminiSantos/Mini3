//
//  TesteView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 03/11/23.
//

import SwiftUI
import PDFKit


@MainActor
struct TesteView: View {
    @State private var pdfURL: URL?
    var body: some View {
        VStack{
            
            PDFDataView()
            
            Button("Generate PDF") {
                pdfURL = generatePDF()
            }
            .padding()
            if let pdfURL = pdfURL {
                PDFKitView(url: pdfURL)
                
                ShareLink("Export PDF", item: pdfURL)
            }
        }
    }
    
    
    // PDF Viewer
    struct PDFKitView: UIViewRepresentable {
        
        let url: URL
        
        func makeUIView(context: Context) -> PDFView {
            let pdfView = PDFView()
            pdfView.document = PDFDocument(url: self.url)
            pdfView.autoScales = true
            return pdfView
        }
        
        func updateUIView(_ pdfView: PDFView, context: Context) {
            // Update pdf if needed
        }
    }
    
    
    // generate pdf from given view
    func generatePDF() -> URL {
        //  Select UI View to render as pdf
        let renderer = ImageRenderer(content:PDFDataView())
        
        let url = URL.documentsDirectory.appending(path: "generatedPDF.pdf")
       
        renderer.render { size, context in
            var pdfDimension = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            guard let pdf = CGContext(url as CFURL, mediaBox: &pdfDimension, nil) else {
                return
            }
            pdf.beginPDFPage(nil)
            context(pdf)
            pdf.endPDFPage()
            pdf.closePDF()
        }
        
        return url
    }
}

//
struct PDFDataView: View {
    var body: some View {
        VStack{
            Text("This view will be added into PDF")
                .font(.title)
            Divider()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Divider()
            Image("apple")
                .resizable()
                .scaledToFit()
                .frame(maxWidth:  200, maxHeight: 200)

        }.padding()
        
    }
}
