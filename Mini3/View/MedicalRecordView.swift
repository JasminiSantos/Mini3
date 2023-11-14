//
//  MedicalRecordView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 31/10/23.
//

import SwiftUI
import PDFKit

@MainActor
struct MedicalRecordView: View {
    @ObservedObject var viewModel: MedicalRecordViewModel
    @ObservedObject private var notePadViewModel = NotePadViewModel(lineType: .dotted)
    @Environment(\.dismiss) var dismiss
    
    @State private var gerado = false
    
    var header: some View {
        CenteredHeader(title: CustomLabels.appointment.rawValue, subtitle: viewModel.getCurrentDateFormatted(), backgroundColor: CustomColor.customDarkBlue, textColor: .white, arrowColor: CustomColor.customOrange)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                header
                petDetails
                notePadBoard
            }
            .edgesIgnoringSafeArea(.all)
            .padding(.horizontal, 60)
            .onAppear {
                viewModel.fetchDoctorData()
                notePadViewModel.initializeCanvasDrawings(count: viewModel.registerTypesArray.count)
            }
        }
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
                    Text(CustomLabels.weightData.rawValue)
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(CustomColor.customDarkBlue)
                    
                    HStack{
                        QuantitySelector(quantity: $viewModel.weight, label: CustomLabels.weight.rawValue, unit: UnitMeasure.kilo.rawValue, backgroundColor: CustomColor.customLightBlue2, borderColor: CustomColor.customDarkBlue)
                        
                        Spacer()
                        
                        DropdownPicker(selectedItem: $viewModel.selectedItem, items: viewModel.conditions, label: CustomLabels.bodyCondition.rawValue,backgroundColor: CustomColor.customLightBlue2, borderColor: CustomColor.customDarkBlue)
                            .padding(.leading, 30)
                    }
                }
                .padding(.top)
                
            }
            .padding(.top, 30)
        }
    }
    var notePadBoard: some View {
        VStack(alignment: .center) {
            VStack (alignment: .leading){
                Text(CustomLabels.appointmentRecord.rawValue)
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(CustomColor.customDarkBlue)
                    .padding(.leading, 60)
                
                CustomHorizontalPicker(
                    selectedItem: $viewModel.selectedRegister,
                    items: viewModel.registerTypesArray,
                    selectedBackgroundColor: .customBlue,
                    selectedTextColor: .white,
                    unselectedTextColor: .black,
                    borderColor: CustomColor.customGray,
                    fontSize: 25
                )
                .frame(maxWidth: .infinity)
            }
            .padding(.top, 30)
            HStack {
                VStack {
                    CustomColorPicker(
                        selectedTool: $notePadViewModel.selectedTool,
                        selectedColor: $notePadViewModel.selectedColor,
                        colorAction: {
                            notePadViewModel.selectedTool = .pencil(notePadViewModel.selectedColor)
                        },
                        eraserAction: {
                            notePadViewModel.selectedTool = .eraser
                        })
                    .padding()
                    
                    UndoRedoToolbar(undoAction: {
                        notePadViewModel.canvasView?.undoManager?.undo()
                    }, redoAction: {
                        notePadViewModel.canvasView?.undoManager?.redo()
                    })
                    
                }
                
                ZStack {
                    NotePad(viewModel: notePadViewModel)
                        .cornerRadius(20)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                        .padding(2)
                }
            }
            .padding(.top)
            HStack{
                Spacer()
                if !gerado {
                    Button("Gerar PDF") {
                        notePadViewModel.saveDrawing()
                        gerado = true
                        if let pdfURL = exportToPDF() {
                            viewModel.savePDFToCloudKit(pdfURL: pdfURL) { error in
                                if let error = error {
                                    print("Error saving PDF to CloudKit: \(error.localizedDescription)")
                                } else {
                                    print("PDF saved to CloudKit successfully")
                                }
                            }
                        }
                    }
                    .buttonStyle(CustomButtonStyle(title: "Exportar", backgroundColor: CustomColor.customGreen, textColor: CustomColor.customDarkBlue2, rightIcon: "checkmark", width: 200))
                } else {
                    if let pdf = exportToPDF() {
                        ShareLink("Export PDF", item: pdf)
                            .buttonStyle(CustomButtonStyle(title: "Exportar", backgroundColor: CustomColor.customGreen, textColor: CustomColor.customDarkBlue2, rightIcon: "checkmark", width: 200))
                    }
                }
                
            }
            .padding(.top)
        }
        .onChange(of: viewModel.selectedRegister) { newRegister in
            notePadViewModel.selectCanvas(at: newRegister)
        }
    }
    
    func exportToPDF() -> URL? {
        
        let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("\(self.viewModel.pet.name.lowercased())_appointment_\(viewModel.getCurrentDateFormatted3().date).pdf")
        let pageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 1.8)
        

        let hostingController = UIHostingController(rootView: MedicalRecordExportView(viewModel: viewModel, notePadViewModel: notePadViewModel))
        hostingController.view.frame = CGRect(origin: .zero, size: pageSize)
        

        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))
        DispatchQueue.main.async {
            do {
                try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
                    context.beginPage()
                    hostingController.view.layer.render(in: context.cgContext)
                    hostingController.view.drawHierarchy(in: hostingController.view.bounds, afterScreenUpdates: true)
                })
                print("wrote file to: \(outputFileURL.path)")
            } catch {
                print("Could not create PDF file: \(error.localizedDescription)")
            }
        }
        return outputFileURL
    }
}
