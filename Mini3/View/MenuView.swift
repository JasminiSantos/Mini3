//
//  MenuView.swift
//  Mini3
//
//  Created by Júlia Savaris on 06/11/23.
//

import SwiftUI

struct MenuView: View {
    @State var text: String = ""
    @State var nomePet: String = ""
    @State var nomeTutor: String = ""
    @State var especie: String = ""
    @State var editing: Bool = false

    @ObservedObject var viewModel: VetProfileViewModel
    
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
                    SearchBar(text: $text, placeholder: "Pesquisar", onCommit: ({}), cor: "AzulClaro")
                    Spacer()
                    NavigationLink(destination: CreateProfileView(), label: {
                        AddNewButton(cor: "AzulClaro", title: "Novo paciente")
                    })


                }
                .padding(.horizontal, 50)
                .padding(.bottom)


                ScrollView(.horizontal){
                    HStack{
                        NavigationLink(destination: PetProfileDetailsView(), label: {
                            PetCard(onClick: "", onCommit: ( { }), nomePet: "Simba", nomeTutor: "Simone Silva", especie: "Canino")
                                .padding(.trailing)
                        })
                        NavigationLink(destination: PetProfileDetailsView(), label: {
                            PetCard(onClick: "", onCommit: ( { }), nomePet: "Oliver", nomeTutor: "Otávio Silva", especie: "Felino")
                                .padding(.trailing)
                        })
                        NavigationLink(destination: PetProfileDetailsView(), label: {
                            PetCard(onClick: "", onCommit: ( { }), nomePet: "Thor", nomeTutor: "John Appleseed", especie: "Canino")
                                .padding(.trailing)
                        })
                        NavigationLink(destination: PetProfileDetailsView(), label: {
                            PetCard(onClick: "", onCommit: ( { }), nomePet: "Mel", nomeTutor: "Ana França", especie: "Canino")
                                .padding(.trailing)
                        })


                    }
                    .padding(.leading, 50)

                    
                }
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
                        SearchBar(text: $text, placeholder: "Pesquisar", onCommit: ({}), cor: "Amarelo")
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
    }
}
