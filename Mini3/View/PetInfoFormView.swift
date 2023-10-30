//
//  PetInfoFormView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 30/10/23.
//

import SwiftUI

struct PetInfoFormView: View {
    @StateObject private var viewModel = PetInfoFormViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                CustomTextField(text: $viewModel.petName, placeholder: "Pet Name", onCommit: {})
                CustomTextField(text: $viewModel.petType, placeholder: "Pet Type (e.g., Dog, Cat)", onCommit: {})
                CustomTextField(text: $viewModel.petAge, placeholder: "Pet Age", onCommit: {}).keyboardType(.numberPad)
                CustomTextField(text: $viewModel.ownerName, placeholder: "Owner's Name", onCommit: {})
                CustomTextField(text: $viewModel.additionalInfo, placeholder: "Additional Information", onCommit: {})
                
                Button(action: viewModel.saveAsPDF) {
                    Text("Save as PDF")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Pet Info Form")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PetInfoFormView()
        }
    }
}

