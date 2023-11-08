//
//  CustomButton.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var backgroundColor: Color
    var textColor: Color
    var leftIcon: String? = ""
    var rightIcon: String? = ""
    var iconPadding: CGFloat = 4
    var width: CGFloat = 0
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                if let leftIcon = leftIcon {
                    Image(systemName: leftIcon)
                        .padding(.trailing, iconPadding)
                }
                
                Text(title)
                    .fontWeight(.bold)
                
                if let rightIcon = rightIcon {
                    Image(systemName: rightIcon)
                        .padding(.leading, iconPadding)
                }
            }
            .foregroundColor(textColor)
            .padding()
            .frame(maxWidth: width == 0 ? .infinity : width)
            .background(backgroundColor)
            .cornerRadius(15)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CustomButtonStyle: ButtonStyle {
    var title: String
    var backgroundColor: Color
    var textColor: Color
    var leftIcon: String? = ""
    var rightIcon: String? = ""
    var iconPadding: CGFloat = 4
    var width: CGFloat = 0
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            if let leftIcon = leftIcon {
                Image(systemName: leftIcon)
                    .padding(.trailing, iconPadding)
            }
            
            Text(title)
                .fontWeight(.bold)
            
            if let rightIcon = rightIcon {
                Image(systemName: rightIcon)
                    .padding(.leading, iconPadding)
            }
        }
        .foregroundColor(textColor)
        .padding()
        .frame(maxWidth: width == 0 ? .infinity : width)
        .background(backgroundColor)
        .cornerRadius(15)
    }
}
