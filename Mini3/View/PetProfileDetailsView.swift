//
//  PetProfileDetailsView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 09/11/23.
//

import SwiftUI

struct PetProfileDetailsView: View {
    
    @ObservedObject var viewModel: PetProfileViewModel
    
    var header: some View {
        Header(title: CustomLabels.animalProfile.rawValue, backgroundColor: CustomColor.customDarkBlue, textColor: .white, arrowColor: CustomColor.customOrange)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                header
                VStack(spacing: 40) {
                    picker
                    if viewModel.selectedCharacter == 1 {
                        petProfile
                    }
                    else {
                        tutorProfile
                    }
                    appointments
                }
                .padding(.all, 50)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.currentState = .editing

        }
    }
    
    var petProfile: some View {
        PetProfileView(viewModel: viewModel)
    }
    var tutorProfile: some View {
        TutorProfileView(viewModel: viewModel)
    }
    
    var picker: some View {
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
    
    var appointments: some View {
        VStack {
            HStack{
                SearchBar(text: $viewModel.search, placeholder: "Pesquisar", onCommit: ({}), cor: "Amarelo")
                Spacer()
                NavigationLink(destination: MedicalRecordView(viewModel: MedicalRecordViewModel(veterinarian: viewModel.veterinarian, pet: viewModel.pet, petOwner: viewModel.petOwner)), label: {
                    AddNewButton(cor: "Amarelo", title: "Nova consulta")
                })
                
            }
            .padding(.bottom)
            
            ScrollView(.horizontal) {
                HStack{
                    ConsultaCard(onClick: "", onCommit: ({}), nomePet: "Simba", nomeTutor: "Simone Silva", data: "23 out. de 2023", hora: "13:40")
                        .padding(.trailing)
                    
                    ConsultaCard(onClick: "", onCommit: ({}), nomePet: "Simba", nomeTutor: "Simone Silva", data: "23 out. de 2023", hora: "13:40")
                        .padding(.trailing)
                    
                    ConsultaCard(onClick: "", onCommit: ({}), nomePet: "Simba", nomeTutor: "Simone Silva", data: "23 out. de 2023", hora: "13:40")
                        .padding(.trailing)
                    
                    ConsultaCard(onClick: "", onCommit: ({}), nomePet: "Simba", nomeTutor: "Simone Silva", data: "23 out. de 2023", hora: "13:40")
                        .padding(.trailing)
                    
                    
                    
                }
                
            }
        }
    }
}
