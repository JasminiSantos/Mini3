//
//  ContentView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/10/23.
//

import SwiftUI
import CloudKit

struct ContentView: View {
    @ObservedObject var viewModel = VetProfileViewModel()

    @ViewBuilder
    private var currentView: some View {
        if viewModel.viewState == .loading  {
            SplashView()
        } else if viewModel.viewState == .menu {
            MenuView(viewModel: MenuViewModel(veterinarian: viewModel.veterinarian!))
        } else if viewModel.viewState == .vetProfile || viewModel.viewState == .iCloudError {
            VetProfileView(viewModel: viewModel)
        }
    }

    var body: some View {
        NavigationStack {
            currentView
        }
        .accentColor(CustomColor.customOrange)
        .onAppear {
            viewModel.viewState = .loading
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                if viewModel.viewState == .loading {
                    viewModel.checkiCloudStatus()
                }
            }
        }
        .alert(isPresented: $viewModel.showiCloudAlert) {
            alert
        }
        
        var alert: Alert {
            guard let alertType = viewModel.activeAlert else {
                return Alert(title: Text("Error"), message: Text("Unknown error."))
            }

            switch alertType {
            case .iCloudError:
                return Alert(
                    title: Text("iCloud Account Required"),
                    message: Text("Please sign in to your iCloud account to enable all features of this app."),
                    primaryButton: .default(Text("Open Settings"), action: viewModel.openSettings),
                    secondaryButton: .cancel()
                )
            case .validationError(let message):
                return Alert(title: Text("Validation Error"), message: Text(message))
            case .customError(let message):
                return Alert(title: Text("Error"), message: Text(message))
            }
        }
    }
}


#Preview {
    ContentView()
}
