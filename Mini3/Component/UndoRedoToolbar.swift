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
        HStack {
            Button(action: {
                print("Undo Pressed")
                undoAction()
            }
            ) {
                Image(systemName: "arrow.uturn.backward.circle.fill")
                    .font(.system(size: 24))
            }
            .buttonStyle(.plain)
            
            Button(action: {
                print("Redo Pressed")
                redoAction()
            }) {
                Image(systemName: "arrow.uturn.forward.circle.fill")
                    .font(.system(size: 24))
            }
            .buttonStyle(.plain)
        }
        .foregroundColor(.primary)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
    }
}

