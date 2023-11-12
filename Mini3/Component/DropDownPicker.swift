//
//  DropDownPicker.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 31/10/23.
//

import SwiftUI

struct DropdownPicker: View {
    @Binding var selectedItem: String
    var items: [String]
    var label: String?
    var backgroundColor: Color
    var borderColor: Color
    var visibleButtons: Bool = true
    var enabled: Bool = true
    
    var body: some View {
        HStack (alignment: .center){
            if let label = label {
                Text(label + ":")
                    .font(.system(size: 20, weight: .regular))
            }
            Menu {
                Picker((label ?? items.first)!, selection: $selectedItem) {
                    ForEach(items, id: \.self) { item in
                        Text(item).tag(item)
                    }
                }
            } label: {
                HStack {
                    HStack {
                        Text(selectedItem)
                            .padding(.leading, 25)
                        Spacer()
                    }
                    .padding(.vertical)
                    .foregroundColor(.black)
                    .background(backgroundColor)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(borderColor, lineWidth: 1)
                    )
                    if visibleButtons {
                        Image(systemName: "chevron.down.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(CustomColor.customLightBlue)
                            .padding(.leading)
                    }
                }
            }.disabled(!enabled)
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
    }
}
