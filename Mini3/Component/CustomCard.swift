//
//  CustomCard1.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 31/10/23.
//

import SwiftUI

struct CustomCard: View {
    var column1Items: [TextLabelPair]
    var column2Items: [TextLabelPair]
    var isThereDivider: Bool = false
    var backgroundColor: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            HStack{
                Spacer()
                VStack(alignment: .leading) {
                    ForEach(column1Items) { item in
                        HStack {
                            Text(item.label + ":")
                                .fontWeight(.semibold)
                            Text(item.text)
                        }
                        .padding(.vertical, 2)
                    }
                }
                Spacer()
            }

            
            if isThereDivider {
                Divider()
            }

            HStack{
                Spacer()
                VStack(alignment: .leading) {
                    ForEach(column2Items) { item in
                        HStack {
                            Text(item.label + ":")
                                .fontWeight(.semibold)
                            Text(item.text)
                        }
                        .padding(.vertical, 2)
                    }
                }
                Spacer()
            }

        }
        .frame(height: 130)
        .background(backgroundColor)
        .cornerRadius(29)
    }
}


struct TextLabelView: View {
    var label: String
    var text: String
    
    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.semibold)
            Spacer()
            Text(text)
        }
    }
}

struct TextLabelPair: Identifiable {
    let id = UUID()
    var label: String
    var text: String
}
