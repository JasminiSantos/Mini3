//
//  MenuView.swift
//  Mini3
//
//  Created by Júlia Savaris on 06/11/23.
//

import SwiftUI

struct MenuView: View {

    @StateObject var viewModel: MenuViewModel
    
    var header: some View {
        Header(title: CustomLabels.menu.rawValue, backgroundColor: CustomColor.customPaletteBlue, textColor: .white, image: "VetPad", arrowColor: CustomColor.customOrange)
        
    }
    
    var body: some View {
        ScrollView {
            header
            content
        }
        .navigationBarBackButtonHidden()
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea()
    }
    
    var content: some View {
        VStack{
            VStack(alignment: .leading) {
                
                HStack{
                    Image(systemName: "pawprint")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("AzulClaro"))
                    
                    
                    Text("Pacientes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Azul"))
                    
                    
                }
                .padding(.leading, 50)
                
                HStack{
                    SearchBar(text: $viewModel.petSearch, placeholder: "Pesquisar", onCommit: ({}), action: {viewModel.filterPets()}, cor: "AzulClaro")
                    Spacer()
                    NavigationLink(destination: CreateProfileView(viewModel: PetProfileViewModel()), label: {
                        AddNewButton(cor: "AzulClaro", title: "Novo paciente")
                    })


                }
                .padding(.horizontal, 50)
                .padding(.bottom)

                if viewModel.petsWithOwners.isEmpty{
                    emptyPets
                        .padding(.bottom, 60)
                }
                else {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.petsWithOwners, id: \.pet.id) { petWithOwner in
                                NavigationLink(destination: PetProfileDetailsView(viewModel: PetProfileViewModel(pet: petWithOwner.pet, petOwner: petWithOwner.owner!, veterinarian: viewModel.veterinarian), menuViewModel: viewModel)) {
                                    PetCard(onClick: {}, onCommit: {}, nomePet: petWithOwner.pet.name, nomeTutor: petWithOwner.owner?.name ?? "Unknown", especie: petWithOwner.pet.specie)
                                        .padding(.trailing)
                                }
                            }
                            .padding(.leading, 50)
                        }
                        .padding(.bottom, 60)
                    }
                }

                
                HStack{
                    Image(systemName: "clock.arrow.circlepath")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Amarelo"))
                    
                    
                    Text("Últimas consultas")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Azul"))
                    
                    
                }
                .padding(.leading, 50)
                VStack {
                    HStack{
                        SearchBar(text: $viewModel.appointmentSearch, placeholder: "Pesquisar", onCommit: ({}), action: {viewModel.filterPDFs()}, cor: "Amarelo")
                        Spacer()
                    }
                    .padding(.horizontal, 50)
                    .padding(.bottom)
                    

                    if viewModel.isLoading {
                        ProgressView()
                    }
                    else {
                        if viewModel.filteredPDFDetails.isEmpty {
                            emptyAppointments
                        } else {
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(viewModel.filteredPDFDetails, id: \.id) { pdfDetail in
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
                                .padding(.leading, 50)
                                .padding(.top, 20)
                            }
                        }
                    }

                }
            }
        }
        .padding(.top, 20)
        .onAppear {
            viewModel.fetchPetData()
            viewModel.fetchAllPDFs()
        }
        
    }
    
    var emptyPets: some View {
        HStack {
            Spacer()
            VStack(alignment: .center, spacing: 40) {
                Image(systemName: "pawprint.fill")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundColor(Color(red: 0.8, green: 0.86, blue: 0.92))
                VStack {
                    Text("Ainda não há nenhum paciente por aqui!")
                    
                    Text("Adicione um novo animal no botão \(Image(systemName: "plus")) Novo Paciente")
                }
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(CustomColor.customPaletteBlue)
            }
            .frame(height: 450)
            Spacer()
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
