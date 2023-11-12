//
//  PetProfileImage.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 09/11/23.
//

import SwiftUI

struct PetProfileImage: View {
    let circleWidth: CGFloat
//    @Binding var showEditButton: Bool
    var addImageAction: () -> Void
    var editImageAction: () -> Void

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: circleWidth, height: circleWidth)
                    .overlay(
                        Circle()
                            .stroke(PetProfileView.Constants.AzulClaro, lineWidth: 7)
                    )
                
                Image(systemName: "pawprint.fill")
                    .font(.system(size: circleWidth / 2.5, weight: .bold))
                    .foregroundColor(Color(red: 0.8, green: 0.86, blue: 0.92))
                
                Button(action: addImageAction) {
                    Image(systemName: "plus")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(PetProfileView.Constants.Branco)
                        .frame(width: 60, height: 60)
                        .background(PetProfileView.Constants.AzulClaro)
                        .clipShape(Circle())
                }
                .offset(x: -(circleWidth/3), y: (circleWidth/3))
                
            }
        }
    }
}

extension PetProfileView {
    struct Constants {
        static let AzulEscuro: Color = Color(red: 0, green: 0.21, blue:0.35)
        static let AzulClaro: Color = Color(red: 0.42, green: 0.6, blue: 0.77)
        static let Branco: Color = Color(red: 0.94, green: 0.95, blue: 0.95)
    }
}

