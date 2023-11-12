//
//  MedicalRecordViewModel.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 02/11/23.
//

import SwiftUI
import PDFKit
import CloudKit

@MainActor
class MedicalRecordViewModel: ObservableObject {
    @ObservedObject var veterinarian = VeterinarianModel(name: "Dr. Juliano Rocha Fernandes", email: "drjulianorocha@gmail.com", crmv: "PR 000000", phoneNumber: "41 0000 0000")
    @ObservedObject var pet = PetModel(name: "Toby", species: "felino", breed: "SRD", age: "9 anos", gender: "macho", furColor: "laranja", tutor: "Mariana Silva", cpf: "00000000-00", address: "Rua da Liberdade, 39 - Cidade")
    @ObservedObject var appointment = AppointmentModel(date: "23 set. 2023", time: "15:00", weight: 6.0, bodyCondition: CondicaoCorporal.ideal5.classification, reasonForVisit: "", observations: "", treatment: "")
    
    let conditions = CondicaoCorporal.allCases.map { $0.classification }
    let registerTypesArray = RegisterType.allCases.map { (id: $0.rawValue, name: $0.description) }
    
    @Published var selectedItem: String = CondicaoCorporal.ideal5.classification
    @Published var selectedRegister: Int = RegisterType.motivoAnamnese.rawValue
    @Published var weight: Int = 0
    
    let cloudKitService = CloudKitService()
    

    func getCurrentDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "dd MMM yyyy - HH:mm"

        let dateString = dateFormatter.string(from: Date())
        
        return dateString
    }
    
    func savePDFToCloudKit(pdfURL: URL, completion: @escaping (Error?) -> Void) {

        let pdfAsset = CKAsset(fileURL: pdfURL)
        

        let objectData: [String: CKRecordValue] = ["pdfFile": pdfAsset]
        

        cloudKitService.saveObject(recordType: "PDF", objectData: objectData, completion: completion)
    }
}
