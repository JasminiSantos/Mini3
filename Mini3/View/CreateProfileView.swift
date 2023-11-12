//
//  CreateProfileView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 08/11/23.
//

import SwiftUI

struct CreateProfileView: View {
    
    @ObservedObject var viewModel = PetProfileViewModel(pet: PetModel(name: "Buddy", species: "Dog", breed: "Labrador", age: "5", gender: "Male", furColor: "Yellow", tutor: "John Doe", cpf: "123.456.789-00", address: "1234 Main St"), petOwner: PetOwnerModel(name: "John Doe", cpf: "123.456.789-00", phoneNumber: "555-1234", address: "1234 Elm Street", email: "johndoe@example.com"))
    
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
    }
    
    var petProfile: some View {
        PetProfileView()
    }
    var tutorProfile: some View {
        TutorProfileView()
    }
    
    var completeButton: some View {
        HStack {
            Spacer()
            CustomButton(title: "Próximo", backgroundColor: CustomColor.customGreen, textColor: CustomColor.customDarkBlue, rightIcon: "chevron.right", width: 200, action: {
                
            })
        }
    }
}

