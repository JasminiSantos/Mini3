//
//  PetProfileCard.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 31/10/23.
//

import SwiftUI

struct PetProfileCard: View {
    var image: Image
    var backgroundColor: Color
    var titleColor: Color
    var title: String
    var itemsColumn1: [TextLabelPair]
    var itemsColumn2: [TextLabelPair]
    var itemsColumn3: [TextLabelPair]
    
    var body: some View {
        HStack(alignment: .center, spacing: 20){
            image
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 140)
                .clipShape(Circle())
                .background(Circle().fill(Color.white))
                .overlay(Circle().stroke(Color.black, lineWidth: 0.5))
                .padding(.leading, 20)
            
            VStack(alignment: .leading){
                Text(title)
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(titleColor)
                
                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading) {
                        ForEach(itemsColumn1) { item in
                            HStack {
                                Text(item.label + ":")
                                    .font(.system(size: 16, weight: .semibold))
                                Text(item.text)
                                    .font(.system(size: 16))
                            }
                            .padding(.vertical, 2)
                            .multilineTextAlignment(.leading)
                        }
                    }
                    
                    HStack {
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(itemsColumn2) { item in
                                HStack {
                                    Text(item.label + ":")
                                        .font(.system(size: 16, weight: .semibold))
                                    Text(item.text)
                                        .font(.system(size: 16))
                                }
                                .padding(.vertical, 2)
                                .multilineTextAlignment(.leading)
                            }
                        }
                        Spacer()
                    }
                }
            }
            
            Rectangle()
                .foregroundColor(.black)
                .frame(width: 1, height: 135)
                .padding(.horizontal, 20)
            
            VStack(alignment: .leading) {
                ForEach(itemsColumn3) { item in
                    HStack(alignment: .top) {
                        Text(item.label + ":")
                            .font(.system(size: 16, weight: .semibold))
                        Text(item.text)
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.vertical, 2)
                    .multilineTextAlignment(.leading)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
        .background(backgroundColor)
        .cornerRadius(29)
    }
}
