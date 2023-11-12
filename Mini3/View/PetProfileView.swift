//
//  PetProfileView.swift
//  Mini3
//
//  Created by Nicole Cardoso Machado on 02/11/23.
//

import SwiftUI

struct PetProfileView: View {

    @ObservedObject var viewModel = PetProfileViewModel(pet: PetModel(name: "Buddy", species: "Dog", breed: "Labrador", age: "5", gender: "Male", furColor: "Yellow", tutor: "John Doe", cpf: "123.456.789-00", address: "1234 Main St"), petOwner: PetOwnerModel(name: "John Doe", cpf: "123.456.789-00", phoneNumber: "555-1234", address: "1234 Elm Street", email: "johndoe@example.com"))
    
    var body: some View {
        VStack {
            
            VStack {
                HStack {
                    VStack (alignment: .leading, spacing: 20){
                        Text("Dados do Pet")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Constants.AzulEscuro)
                            .padding(.bottom, 25)
                        VStack(alignment: .leading) {
                            Text("Nome do animal:")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.black)
                            
                            CustomTextField(text: $viewModel.pet.name, placeholder: "", backgroundColor: .white, borderColor: Constants.AzulClaro, onCommit: {
                                
                            })
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Idade:")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.black)
                            
                            CustomTextField(text: $viewModel.pet.age, placeholder: "", backgroundColor: .white, borderColor: Constants.AzulClaro, onCommit: {
                                
                            })
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Espécie:")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.black)
                            
                            DropdownPicker(selectedItem: $viewModel.selectedSpecie, items: viewModel.allSpecies,backgroundColor: Color(red: 0.42, green: 0.6, blue: 0.77).opacity(0.35), borderColor: Constants.AzulClaro)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Raça:")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.black)
                            
                            
                            CustomTextField(text: $viewModel.pet.breed, placeholder: "", backgroundColor: .white, borderColor: Constants.AzulClaro, onCommit: {
                                
                            })
                        }
                        
                    }//FIM DA VSTACK

                    VStack (alignment: .center, spacing: 8){
                        HStack (alignment: .top) {
                            PetProfileImage(
                                circleWidth: 230,
//                                showEditButton: .constant(true),
                                addImageAction: {},
                                editImageAction: {}
                            )
                            
                            //BOTÃO DE EDIÇÃO
                            if viewModel.currentState == .editing {
                                Button(action: {}) {
                                    Image(systemName: "square.and.pencil")
                                        .font(.system(size: 28, weight: .bold))
                                        .foregroundColor(Constants.Branco)
                                        .frame(width: 50, height: 50)
                                        .background(Constants.AzulEscuro)
                                        .cornerRadius(360)
                                }
                            }
                        }
                        
                        Spacer()
                            .frame(height: 85)
                        
                        VStack {
                            VStack(alignment: .leading) {
                                Text("Sexo: ")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(.black)
                                
                                DropdownPicker(selectedItem: $viewModel.selectedGender, items: viewModel.allPetGenders,backgroundColor: Color(red: 0.42, green: 0.6, blue: 0.77).opacity(0.35), borderColor: Constants.AzulClaro)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Pelagem:")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(.black)
                                
                                CustomTextField(text: $viewModel.pet.furColor, placeholder: "", backgroundColor: .white, borderColor: Constants.AzulClaro, onCommit: {
                                    
                                })
                            }
                        }
                        
                        
                    }//FIM DA VSTACK
                    .padding(.leading, 30)
                    
                    
                }
                //BOTÃO DE SALVAR ALTERAÇÕES
                if viewModel.currentState == .editing {
                    Button(action: {}){
                        Image(systemName: "checkmark")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Constants.Branco)
                        
                        Text("Salvar alterações")
                            .font(.system(size: 32, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Constants.Branco)
                    }
                    .foregroundColor(.clear)
                    .frame(width: 350, height: 60)
                    .background(Constants.AzulClaro)
                    .cornerRadius(18)
                    .padding(.top, 30)
                }
                Image(systemName: "pawprint.fill")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Constants.AzulClaro)
                    .padding(.vertical, 30)
                
            }//FIM DA VSTACK
            .padding(40)
            
            
        }//FIM DA ZSTACK
        .background(
            Rectangle()
                .foregroundColor(.clear)
                .background(Color(red: 0.88, green: 0.92, blue: 0.95))
                .cornerRadius(30)
        )
        .ignoresSafeArea(.all)
    }
    
}


#Preview {
    PetProfileView()
}
