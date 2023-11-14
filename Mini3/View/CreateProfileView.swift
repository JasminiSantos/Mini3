//
//  CreateProfileView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 08/11/23.
//

import SwiftUI

struct CreateProfileView: View {
    
    @ObservedObject var viewModel: PetProfileViewModel
    
    var header: some View {
        Header(title: CustomLabels.createPetProfile.rawValue, backgroundColor: CustomColor.customDarkBlue, textColor: .white, arrowColor: CustomColor.customOrange)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                header
                VStack(spacing: 30) {
                    petProfile
                    tutorProfile
                    completeButton
                }
                .padding(.all, 50)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.currentState = .creating
        }
        .alert(isPresented: $viewModel.showAlert) {
            alert
        }
    }
    
    var petProfile: some View {
        PetProfileView(viewModel: viewModel)
    }
    var tutorProfile: some View {
        TutorProfileView(viewModel: viewModel)
    }
    
    var completeButton: some View {
        HStack {
            Spacer()
            CustomButton(title: "Próximo", backgroundColor: CustomColor.customGreen, textColor: CustomColor.customDarkBlue, rightIcon: "chevron.right", width: 200, action: {
                viewModel.savePetAndOwner()
            })
        }
    }
    
    var alert: Alert {
        Alert(
            title: Text("Error"),
            message: Text(viewModel.alertMessage ?? "Um erro ocorreu. Por favor tente mais tarde!"),
            dismissButton: .default(Text("OK"))
        )
    }
}

