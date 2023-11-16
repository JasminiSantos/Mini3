//
//  AppointmentPDFView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 14/11/23.
//

import SwiftUI
import PDFKit

struct AppointmentPDFView: View {
    var pdfURL: String?
    
    var header: some View {
        Header(title: CustomLabels.appointment.rawValue, backgroundColor: CustomColor.customDarkBlue, textColor: .white, arrowColor: CustomColor.customOrange)
        
    }
    var pdf: some View {
        VStack {
            if let pdfURL, let url = URL(string: pdfURL) {
                PDFReader(url: url)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("PDF not found")
            }
        }
    }

    var body: some View {
        pdf
    }
}

