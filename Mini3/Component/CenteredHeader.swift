//
//  CenteredHeader.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 31/10/23.
//

import SwiftUI

struct CenteredHeader: View {
    var title: String
    var subtitle: String
    var backgroundColor: Color
    var textColor: Color
    var arrowColor: Color
    
    var body: some View {
        HStack(alignment: .center) {
            
            Spacer()
            
            VStack(alignment: .center, spacing: 5) {
                Text(title)
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(textColor)
                Text(subtitle)
                    .font(.system(size: 23, weight: .semibold))
                    .foregroundColor(textColor)
            }
            
            Spacer()
        }
        .frame(width: 700)
        .padding(.vertical)
        .padding(.top)
        .background(backgroundColor)
        .clipShape(
            .rect(
                topLeadingRadius: 0,
                bottomLeadingRadius: 54,
                bottomTrailingRadius: 54,
                topTrailingRadius: 0
            )
        )
        .edgesIgnoringSafeArea(.all)
    }
}
