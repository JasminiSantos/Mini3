//
//  QuantitySelector.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 31/10/23.
//

import SwiftUI

struct QuantitySelector: View {
    @Binding var quantity: Int
    var label: String
    var unit: String
    var backgroundColor: Color
    var borderColor: Color
    var visibleButtons: Bool = true
    var enabled: Bool = true
    
    var quantityString: Binding<String> {
        Binding<String>(
            get: { "\(self.quantity)\(self.unit)" },
            set: {
                let numberString = $0.replacingOccurrences(of: self.unit, with: "").trimmingCharacters(in: .whitespaces)
                self.quantity = Int(numberString) ?? self.quantity
            }
        )
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Text(label + ":")
                .font(.system(size: 20, weight: .regular))
            if visibleButtons {
                Button(action: {
                    if quantity > 0 {
                        quantity -= 1
                    }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(CustomColor.customLightBlue)
                }
            }
            
            TextField("0", text: quantityString)
                .keyboardType(.numberPad)
                .frame(width: 115, height: 40)
                .padding(5)
                .background(backgroundColor)
                .cornerRadius(15)
                .multilineTextAlignment(.center)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(borderColor, lineWidth: 1)
                )
                .disabled(!enabled)
            if visibleButtons {
                Button(action: {
                    quantity += 1
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(CustomColor.customLightBlue)
                }
            }
        }
    }
}

