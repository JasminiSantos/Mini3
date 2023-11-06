//
//  MedicalRecordExportView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 03/11/23.
//

import SwiftUI

@MainActor
struct MedicalRecordExportView: View {
    
    weak var viewModel: MedicalRecordViewModel?
    weak var notePadViewModel: NotePadViewModel?
    
    let column1Items = [
        TextLabelPair(label: "Médico Veterinário", text: "Dr. Juliano Rocha Fernandes"),
        TextLabelPair(label: "E-mail", text: "drjulianorocha@gmail.com")
    ]
    
    let column2Items = [
        TextLabelPair(label: "CRMV", text: "PR 000000"),
        TextLabelPair(label: "Telefone", text: "41 0000 0000")
    ]
    var header: some View {
        Header(title: "Prontuário de Consulta", subtitle: "23 de setembro de 2023", subtitle2: "Horário: 15:00", backgroundColor: CustomColor.customDarkBlue, textColor: .white, arrowColor: CustomColor.customOrange)
    }
    
    var body: some View {
        ScrollView {
            header
            VStack {
                petDetails
                notePadBoard
            }
            .padding(.horizontal, 60)
        }
        .edgesIgnoringSafeArea(.all)
    }
    var petDetails: some View {
        VStack{
            VStack{
                CustomCard(column1Items: column1Items, column2Items: column2Items, isThereDivider: false, backgroundColor: CustomColor.customMint.opacity(0.3))
                Spacer()
                    .frame(height: 50)
                
                PetProfileCard(
                    image: Image("profileImage"), backgroundColor: CustomColor.customLightBlue.opacity(0.2), titleColor: CustomColor.customDarkBlue , title: "Toby",
                    itemsColumn1: [
                        TextLabelPair(label: "Espécie", text: "felino"),
                        TextLabelPair(label: "Idade", text: "9 anos"),
                        TextLabelPair(label: "Sexo", text: "macho")
                    ],
                    itemsColumn2: [
                        TextLabelPair(label: "Raça", text: "SRD"),
                        TextLabelPair(label: "Pelagem", text: "laranja")
                    ],
                    itemsColumn3: [
                        TextLabelPair(label: "Tutor", text: "Mariana Silva"),
                        TextLabelPair(label: "CPF", text: "0000000-00"),
                        TextLabelPair(label: "Endereço", text: "Rua da Liberdade, 39 - Cidade")
                    ]
                )
                VStack (alignment: .leading){
                    Text("Dados de Peso")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(CustomColor.customDarkBlue)
                    
                    HStack{
                        QuantitySelector(quantity: .constant(10), label: "Peso", unit: "kg", backgroundColor: CustomColor.customGray2, borderColor: CustomColor.customGray2, visibleButtons: false, enabled: false)
                        
                        Spacer()
                        
//                        DropdownPicker(selectedItem: .constant("aaa"), items: .constant(viewModel?.conditions), label: "Condição corporal",backgroundColor: CustomColor.customGray2, borderColor: CustomColor.customGray2, visibleButtons: false, enabled: false)
                    }
                }
                .padding(.top)
                
            }
            .padding(.top, 30)
        }
    }
    var notePadBoard: some View {
        VStack(alignment: .leading) {
            Text("Registro da consulta")
                .font(.system(size: 30, weight: .semibold))
                .foregroundColor(.black)
                .padding(.top, 30)
            
            
            VStack(alignment: .leading) {
                if let registerTypes = viewModel?.registerTypesArray {
                    ForEach(registerTypes, id: \.id) { register in
                        VStack(alignment: .leading, spacing: 20) {
                            Text(register.name)
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.top)
                            
                            ZStack {
                                if let notePadViewModel = notePadViewModel, let image =  notePadViewModel.getImage(at: register.id){
                                    Image(uiImage: image)
                                }
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 1)
                                    .padding(2)
                            }
                            .frame(height: 400)
                        }
                    }
                }
                
        
                HStack {
                    Spacer()
                    
                    Text("Assinatura")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.black)
                        
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                            .padding(2)
                    }
                    .padding(.leading, 50)
                    .frame(width: 500, height: 100)
                    Spacer()
                }
                .padding(.top, 40)
            }
            .padding(.top, 20)
        }
    }
}
