//
//  MedicalRecordExportView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 03/11/23.
//

import SwiftUI

@MainActor
struct MedicalRecordExportView: View {
    
    @StateObject var viewModel: MedicalRecordViewModel
    @StateObject var notePadViewModel: NotePadViewModel
    
    var header: some View {
        Header(title: CustomLabels.appointment.rawValue, subtitle: viewModel.getCurrentDateFormatted2().date, subtitle2: viewModel.getCurrentDateFormatted2().time, backgroundColor: CustomColor.customDarkBlue, textColor: .white, arrowColor: CustomColor.customOrange)
        
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
                CustomCard(
                    column1Items: [
                        TextLabelPair(label: CustomLabels.vetDoctor.rawValue, text: viewModel.veterinarian.name),
                        TextLabelPair(label: CustomLabels.email.rawValue, text: viewModel.veterinarian.email),
                    ],
                    column2Items: [
                        TextLabelPair(label: CustomLabels.crmv.rawValue, text: viewModel.veterinarian.crmv),
                        TextLabelPair(label: CustomLabels.phoneNumber.rawValue, text: viewModel.veterinarian.phoneNumber),
                    ],
                    isThereDivider: false,
                    backgroundColor: CustomColor.customMint.opacity(0.3)
                )
                Spacer()
                    .frame(height: 50)
                
                PetProfileCard(
                    image: Image("profileImage"), backgroundColor: CustomColor.customLightBlue.opacity(0.2), titleColor: CustomColor.customDarkBlue, title: viewModel.pet.name,
                    itemsColumn1: [
                        TextLabelPair(label: CustomLabels.specie.rawValue, text: viewModel.pet.specie),
                        TextLabelPair(label: CustomLabels.age.rawValue, text: viewModel.pet.age),
                        TextLabelPair(label: CustomLabels.gender.rawValue, text: viewModel.pet.gender)
                    ],
                    itemsColumn2: [
                        TextLabelPair(label: CustomLabels.breed.rawValue, text: viewModel.pet.breed),
                        TextLabelPair(label: CustomLabels.furColor.rawValue, text: viewModel.pet.furColor)
                    ],
                    itemsColumn3: [
                        TextLabelPair(label: CustomLabels.tutor.rawValue, text: viewModel.petOwner.name),
                        TextLabelPair(label: CustomLabels.cpf.rawValue, text: viewModel.petOwner.cpf),
                        TextLabelPair(label: CustomLabels.address.rawValue, text: viewModel.petOwner.address)
                    ]
                )
                VStack (alignment: .leading){
                    Text("Dados de Peso")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(CustomColor.customDarkBlue)
                    
                    HStack{
                        QuantitySelector(quantity: $viewModel.weight, label: CustomLabels.weight.rawValue, unit: UnitMeasure.kilo.rawValue, backgroundColor: CustomColor.customLightBlue2, borderColor: CustomColor.customDarkBlue, visibleButtons: false, enabled: false)
                        
                        Spacer()
                        
                        DropdownPicker(selectedItem: $viewModel.selectedItem, items: viewModel.conditions, label: CustomLabels.bodyCondition.rawValue,backgroundColor: CustomColor.customLightBlue2, borderColor: CustomColor.customDarkBlue, visibleButtons: false, enabled: false)
                            .padding(.leading, 30)
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
                ForEach(viewModel.registerTypesArray, id: \.id) { register in
                    VStack(alignment: .leading, spacing: 20) {
                        Text(register.name)
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.top)
                        
                        ZStack {
                            if let image =  notePadViewModel.getImage(at: register.id){
                                Image(uiImage: image)
                            }
                            
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 1)
                                .padding(2)
                        }
                        .frame(height: 400)
                    }
                }
                
        
                HStack {
                    Spacer()
                    
                    Text("Assinatura")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.black)
                        
                    ZStack {
                        if let signatureImage = viewModel.signatureImage {
                            Image(uiImage: signatureImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 500, height: 100)
                                .cornerRadius(20)
                        }
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                            .padding(2)
                            .frame(width: 500, height: 100)
                    }
                    .padding(.leading, 50)
                    Spacer()
                }
                .padding(.top, 40)
            }
            .padding(.top, 20)
        }
    }
}
