//
//  ContentView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: MedicalRecordView(), label: {
                    Text("Acessar")
                })
            }
            .padding()
        }
        .accentColor(CustomColor.customOrange)
    }
}

#Preview {
    ContentView()
}
