//
//  UndoRedoToolbar.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI

struct UndoRedoToolbar: View {
    var undoAction: () -> Void
    var redoAction: () -> Void
    
    var body: some View {
        VStack {
            Button(action: {
                redoAction()
            }) {
                Image(systemName: "arrow.uturn.forward")
                    .font(.system(size: 24))
            }
            .buttonStyle(.plain)
            .padding(.vertical, 5)
            
            Rectangle()
                .frame(width: 40, height: 1)
                .foregroundColor(.black)
            
            Button(action: {
                undoAction()
            }
            ) {
                Image(systemName: "arrow.uturn.backward")
                    .font(.system(size: 24))
            }
            .buttonStyle(.plain)
            .padding(.vertical, 5)
        }
        .foregroundColor(.primary)
        .padding(.all, 5)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.2)))
    }
}

