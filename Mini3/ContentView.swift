//
//  ContentView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    @State var textInput: String = ""
    
    var body: some View {
        VStack {
            CustomTextField(text: $textInput, placeholder: "Enter text", onCommit: {
                print("Text field commit action")
            })
            .padding()
        
            CustomButton(title: "Botão", action: {
        
            }, backgroundColor: .cyan, textColor: .white)
        
                        PDFReader(url: URL(string: "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf")!)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
