//
//  MenuView.swift
//  Mini3
//
//  Created by Júlia Savaris on 06/11/23.
//

import SwiftUI

struct MenuView: View {

    @StateObject var viewModel: MenuViewModel
    
    var body: some View {
        ZStack{
            
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
                    SearchBar(text: $viewModel.petSearch, placeholder: "Pesquisar", onCommit: ({}), cor: "AzulClaro")
                    Spacer()
                    NavigationLink(destination: CreateProfileView(viewModel: PetProfileViewModel()), label: {
                        AddNewButton(cor: "AzulClaro", title: "Novo paciente")
                    })


                }
                .padding(.horizontal, 50)
                .padding(.bottom)


                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.petsWithOwners, id: \.pet.id) { petWithOwner in
                            NavigationLink(destination: PetProfileDetailsView(viewModel: PetProfileViewModel(pet: petWithOwner.pet, petOwner: petWithOwner.owner!, veterinarian: viewModel.veterinarian))) {
                                PetCard(onClick: {}, onCommit: {}, nomePet: petWithOwner.pet.name, nomeTutor: petWithOwner.owner?.name ?? "Unknown", especie: petWithOwner.pet.specie)
                                    .padding(.trailing)
                            }
                        }
                    }
                    .padding(.leading, 50)
                }
                .frame(width: 210, height: 210)
                .padding(.bottom, 60)
                
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
                        SearchBar(text: $viewModel.appointmentSearch, placeholder: "Pesquisar", onCommit: ({}), cor: "Amarelo")
                        Spacer()
                    }
                    .padding(.horizontal, 50)
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
                        .padding(.leading, 50)
                        
                    }
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.fetchPetData()
        }
    }
}
