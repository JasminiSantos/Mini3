//
//  PetProfileDetailsView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 09/11/23.
//

import SwiftUI

struct PetProfileDetailsView: View {
    
    @StateObject var viewModel: PetProfileViewModel
    @ObservedObject var menuViewModel: MenuViewModel
    
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
            menuViewModel.fetchAllPDFs(forPetID: viewModel.pet.id)
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
            if menuViewModel.isLoading {
                ProgressView()
            }
            else {
                if menuViewModel.filteredPDFDetails.isEmpty {
                    emptyAppointments
                } else {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(menuViewModel.filteredPDFDetails, id: \.id) { pdfDetail in
                                NavigationLink(destination: AppointmentPDFView(pdfURL: pdfDetail.pdfURL.absoluteString)) {
                                    ConsultaCard(
                                        onClick: "",
                                        onCommit: ({}),
                                        nomePet: pdfDetail.pet.name ,
                                        nomeTutor: pdfDetail.petOwner?.name ?? "Unknown",
                                        data: pdfDetail.formattedDate,
                                        hora: pdfDetail.formattedTime
                                    )
                                    .padding(.trailing)
                                }
                            }
                        }
                        .padding(.top, 20)
                    }
                }
            }


        }
    }
    var emptyAppointments: some View {
        HStack {
            Spacer()
            VStack {
                Text("Nenhuma consulta disponível.")
                
                Text("Crie uma nova consulta no perfil do paciente desejado")
            }
            .font(.system(size: 24, weight: .medium))
            .foregroundStyle(CustomColor.customPaletteYellow)
            Spacer()
        }
        .frame(height: 200)
    }
}
