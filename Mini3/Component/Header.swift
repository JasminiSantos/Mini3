//
//  Header.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 03/11/23.
//

import SwiftUI

struct Header: View {
    var title: String
    var subtitle: String?
    var subtitle2: String?
    var backgroundColor: Color
    var textColor: Color
    var arrowColor: Color
    var cornerRadius: CGFloat = 0
    
    var body: some View {
        HStack(alignment: .center) {

            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundColor(textColor)
                }
                .padding(.leading)

                Spacer()
                
                VStack (alignment: .leading, spacing: 5){
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.system(size: 23, weight: .semibold))
                            .foregroundColor(textColor)
                    }
                    if let subtitle2 = subtitle2 {
                        Text(subtitle2)
                            .font(.system(size: 23, weight: .semibold))
                            .foregroundColor(textColor)
                    }
                }
            }
            .padding(.horizontal, 40)

        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
        .padding(.top)
        .background(backgroundColor)
        .clipShape(
            .rect(
                topLeadingRadius: 0,
                bottomLeadingRadius: cornerRadius,
                bottomTrailingRadius: cornerRadius,
                topTrailingRadius: 0
            )
        )
    }
}
