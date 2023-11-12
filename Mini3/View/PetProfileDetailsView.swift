//
//  PetProfileViewDetails.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 09/11/23.
//

import SwiftUI

struct PetProfileViewDetails: View {
    
    @ObservedObject var viewModel = PetProfileViewModel(pet: PetModel(name: "Buddy", species: "Dog", breed: "Labrador", age: "5", gender: "Male", furColor: "Yellow", tutor: "John Doe", cpf: "123.456.789-00", address: "1234 Main St"), petOwner: PetOwnerModel(name: "John Doe", cpf: "123.456.789-00", phoneNumber: "555-1234", address: "1234 Elm Street", email: "johndoe@example.com"))
    
    var header: some View {
        Header(title: CustomLabels.animalProfile.rawValue, backgroundColor: CustomColor.customDarkBlue, textColor: .white, arrowColor: CustomColor.customOrange)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                header
                VStack(spacing: 30) {
                    petProfile
                    tutorProfile
                }
                .padding(.all, 50)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var petProfile: some View {
        PetProfileView()
    }
    var tutorProfile: some View {
        TutorProfileView()
    }
    
    var content: some View {
        CustomHorizontalPicker(
            selectedItem: $viewModel.selectedCharacter,
            items: viewModel.allCharacters,
            selectedBackgroundColor: .customBlue,
            selectedTextColor: .white,
            unselectedTextColor: .black,
            borderColor: CustomColor.customGray,
            fontSize: 25
        )
        .frame(maxWidth: .infinity)
    }
}
