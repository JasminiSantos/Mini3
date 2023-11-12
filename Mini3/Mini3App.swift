//
//  Mini3App.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI

@main
struct Mini3App: App {
    @ObservedObject var viewModel = VetProfileViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
