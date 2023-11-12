//
//  CheckButton.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 10/11/23.
//

import SwiftUI

struct CheckButton: View {
    @Binding var isChecked: Bool
    var borderColor: Color = .blue
    var onChecked: (() -> Void)?

    var body: some View {
        Button(action: toggleCheck) {
            RoundedRectangle(cornerRadius: 8)
                .stroke(borderColor, lineWidth: 2)
                .overlay(
                    isChecked ? Image(systemName: "checkmark") : nil
                )
                .foregroundColor(.black)
                .frame(width: 30, height: 30)
        }
    }

    private func toggleCheck() {
        isChecked.toggle()
        onChecked?()
    }
}
