//
//  VetProfileView.swift
//  Mini3
//
//  Created by Júlia Savaris on 31/10/23.
//

import SwiftUI
import CloudKit

struct VetProfileView: View {
    @ObservedObject var viewModel: VetProfileViewModel
    @ObservedObject private var notePadViewModel = NotePadViewModel(lineType: .none)
    
    var header: some View {
        Header(title: CustomLabels.createProfile.rawValue, backgroundColor: CustomColor.customDarkBlue, textColor: .white, arrowColor: CustomColor.customOrange)
        
    }
    
    var body: some View {
        ScrollView {
            VStack {
                NavigationLink(destination: MenuView(viewModel: viewModel), isActive: $viewModel.navigateToMenuView) {
                    EmptyView()
                }
                header
                VStack {
                    form
                    checkButton
                    formButton
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 70)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            notePadViewModel.initializeCanvasDrawings(count: 1)
            viewModel.checkiCloudStatus()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            viewModel.checkiCloudStatus()
        }
        .alert(isPresented: $viewModel.showiCloudAlert) {
            alert
        }
    }
    
    var form: some View {
        VStack{
            VStack (alignment: .leading) {
                Text("Dados do Médico Veterinário")
                    .fontWeight(.semibold)
                    .font(.title)
                    .padding(.vertical)
                
                Text("Nome completo:")
                    .font(.system(size: 24, weight: .medium))
                
                CustomTextField(text: $viewModel.name, placeholder: "", backgroundColor: .white, borderColor: CustomColor.customPaletteYellow, onCommit: {
                    
                })
                .padding(.bottom)
                HStack{
                    VStack(alignment: .leading){
                        Text("CRMV:")
                            .font(.system(size: 24, weight: .medium))
                        CustomTextField(text: $viewModel.crmv, placeholder: "", backgroundColor: .white, borderColor: CustomColor.customPaletteYellow, onCommit: {
                            
                        })
                    }
                    
                    .padding(.trailing)
                    VStack(alignment: .leading) {
                        Text("Telefone:")
                            .font(.system(size: 24, weight: .medium))
                        CustomTextField(text: $viewModel.phone, placeholder: "", backgroundColor: .white, borderColor: CustomColor.customPaletteYellow, onCommit: {
                            
                        })
                        
                    }
                }
                .padding(.bottom)
                
                
                Text("E-mail:")
                    .font(.system(size: 24, weight: .medium))
                
                CustomTextField(text: $viewModel.email, placeholder: "", backgroundColor: .white, borderColor: CustomColor.customPaletteYellow, onCommit: {
                    
                })
                .padding(.bottom)
                
                Text("CPF")
                    .font(.system(size: 24, weight: .medium))
                
                CustomTextField(text: $viewModel.cpf, placeholder: "", backgroundColor: .white, borderColor: CustomColor.customPaletteYellow, onCommit: {
                    
                })
                .padding(.bottom)
                
                Text("Sua assinatura:")
                    .font(.system(size: 24, weight: .medium))
                
                ZStack {
                    NotePad(viewModel: notePadViewModel)
                        .cornerRadius(20)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(CustomColor.customPaletteYellow, lineWidth: 1)
                        .padding(2)
                }
                .frame(width: .infinity, height: 100)
                .padding(.bottom)
                    
                HStack {
                    UndoRedoToolbar(orientation: .horizontal, undoAction: {
                        notePadViewModel.undo()
                    }, redoAction: {
                        notePadViewModel.redo()
                    })
                    HStack {
                        Spacer()
                        Text("Esta assinatura será utilizada nos documentos de prontuários")
                            .font(.system(size: 24, weight: .light))
                        Spacer()
                    }
                }
                
                HStack{
                    Spacer()
                    Image(systemName: "stethoscope")
                        .font(.title)
                        .foregroundColor(Color("Amarelo"))
                    Spacer()
                    
                }
                .padding(.vertical)
            }
            .padding(30)
            
            
        }
        .background(
            Color(CustomColor.customLightOrange)
                .cornerRadius(29)
        )
        .padding(.top, 30)
        
        
    }
    
    var formButton: some View {
        HStack{
            Spacer()
            CustomButton(title: "Próximo", backgroundColor: Color("Menta"), textColor: .black, rightIcon: "chevron.right", width: 200, action: {
                viewModel.checkiCloudStatus()
                if !viewModel.showiCloudAlert && !viewModel.accountExists && viewModel.isChecked{
                    notePadViewModel.saveDrawing()
                    notePadViewModel.getImages()
                    if let image = notePadViewModel.canvasImages.first {
                        viewModel.signatureImage = image
                    }
                    viewModel.createDoctorData()
                }
            })
        }
        .padding(.top, 30)
    }
    
    var checkButton: some View {
        HStack {
            CheckButton(isChecked: $viewModel.isChecked, borderColor: CustomColor.customPaletteYellow)

            Text("Declaro que li e concordo com os ")
                .font(.system(size: 24, weight: .regular))

            NavigationLink(destination: TermsAndConditionsView()) {
                Text("Termos e Condições Gerais de Uso")
                    .underline()
                    .foregroundColor(.blue)
            }
            .font(.system(size: 24, weight: .regular))
        }
        .padding(.top)
    }
    
    var alert: Alert {
        guard let alertType = viewModel.activeAlert else {
            return Alert(title: Text("Error"), message: Text("Unknown error."))
        }

        switch alertType {
        case .iCloudError:
            return Alert(
                title: Text("iCloud Account Required"),
                message: Text("Please sign in to your iCloud account to enable all features of this app."),
                primaryButton: .default(Text("Open Settings"), action: viewModel.openSettings),
                secondaryButton: .cancel()
            )
        case .validationError(let message):
            return Alert(title: Text("Validation Error"), message: Text(message))
        case .customError(let message):
            return Alert(title: Text("Error"), message: Text(message))
        }
    }


}

#Preview {
    PetProfileView()
}
