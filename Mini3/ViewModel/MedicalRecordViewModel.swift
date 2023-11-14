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
    @ObservedObject var veterinarian: Veterinarian
    @ObservedObject var pet: Pet
    @ObservedObject var petOwner: PetOwner
    @ObservedObject var appointment = Appointment(date: "23 set. 2023", time: "15:00", weight: 6.0, bodyCondition: CondicaoCorporal.ideal5.classification, reasonForVisit: "", observations: "", treatment: "")
    
    let conditions = CondicaoCorporal.allCases.map { $0.classification }
    let registerTypesArray = RegisterType.allCases.map { (id: $0.rawValue, name: $0.description) }
    
    @Published var selectedItem: String = CondicaoCorporal.ideal5.classification
    @Published var selectedRegister: Int = RegisterType.motivoAnamnese.rawValue
    @Published var weight: Int = 0
    
    @Published var signatureImage: UIImage? = nil
    
    let cloudKitService = CloudKitService()
    
    init(veterinarian: Veterinarian, pet: Pet, petOwner: PetOwner){
        self.veterinarian = veterinarian
        self.pet = pet
        self.petOwner = petOwner
    }
    

    func getCurrentDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "dd MMM yyyy - HH:mm"

        let dateString = dateFormatter.string(from: Date())
        
        return dateString
    }
    
    func getCurrentDateFormatted2() -> (date: String, time: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "dd 'de' MMMM 'de' yyyy - 'Horário: 'HH:mm"

        let formattedString = dateFormatter.string(from: Date())
        
        let dateTimeComponents = formattedString.components(separatedBy: " - ")
        guard dateTimeComponents.count == 2 else {
            return ("Data não disponível", "Horário não disponível")
        }

        let datePart = dateTimeComponents[0]
        let timePart = dateTimeComponents[1]
        
        return (date: datePart, time: timePart)
    }
    func getCurrentDateFormatted3() -> (date: String, time: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "dd-MM-yyyy - HH:mm" // Updated date format

        let formattedString = dateFormatter.string(from: Date())
        
        let dateTimeComponents = formattedString.components(separatedBy: " - ")
        guard dateTimeComponents.count == 2 else {
            return ("Data não disponível", "Horário não disponível")
        }

        let datePart = dateTimeComponents[0]
        let timePart = dateTimeComponents[1]
        
        return (date: datePart, time: timePart)
    }

    func savePDFToCloudKit(pdfURL: URL, completion: @escaping (Error?) -> Void) {

        let pdfAsset = CKAsset(fileURL: pdfURL)
        

        let objectData: [String: CKRecordValue] = ["pdfFile": pdfAsset]
        

        cloudKitService.saveObject(recordType: "PDF", objectData: objectData, completion: completion)
    }
    
    func fetchSignature() {

        cloudKitService.fetchRecordByID(recordType: "Doctor", recordID: veterinarian.id) { [weak self] (record, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching signature: \(error)")
                    return
                }
                if let record = record,
                   let signatureAsset = record["signature"] as? CKAsset,
                   let fileURL = signatureAsset.fileURL,
                   let data = try? Data(contentsOf: fileURL),
                   let image = UIImage(data: data) {
                    self?.signatureImage = image
                } else {
                    print("Failed to load signature image.")
                }
            }
        }
    }
    func fetchDoctorData() {
        cloudKitService.fetchRecords(recordType: "Doctor") { [weak self] records, error in
            DispatchQueue.main.async {
                if let records = records {
                    let result = records.compactMap { record -> Veterinarian? in
                        if let id = record["id"] as? String,
                           let name = record["name"] as? String,
                           let crmv = record["crmv"] as? String,
                           let phone = record["phone"] as? String,
                           let email = record["email"] as? String,
                           let cpf = record["cpf"] as? String,
                           let asset = record["signature"] as? CKAsset,
                           let fileURL = asset.fileURL {
                            do {
                                let imageData = try Data(contentsOf: fileURL)
                                self?.signatureImage = UIImage(data: imageData)
                            } catch {
                                print("Error loading image data: \(error)")
                            }
                            return Veterinarian(id: UUID(uuidString: id)!, name: name, email: email, crmv: crmv, cpf: cpf, phoneNumber: phone, signatureUrl: fileURL.path)
                        } else {
                            print("Failed to process record: \(record)")
                            return nil
                        }
                    }
                    if let vet = result.first {
                        self?.veterinarian = vet
                    }
//                    self?.isLoading = false
//                    self?.viewState = self?.veterinarian != nil ? .menu : .vetProfile
//                    completion()
                } else if let error = error {
//                    self?.isLoading = false
                    print("Error fetching doctor from iCloud: \(error.localizedDescription)")
//                    completion()
                } else {
//                    self?.isLoading = false
//                    self?.viewState = .vetProfile
//                    completion()
                }
            }
        }
    }
    
    
    func saveAppointmentForPet() {

        let appointmentRecord = self.appointment.asCKRecord
        cloudKitService.save(record: appointmentRecord) { [weak self] result in
            switch result {
            case .success(let savedAppointmentRecord):
                let petRecord = self?.pet.asCKRecord

                self?.cloudKitService.createReference(from: petRecord!, to: savedAppointmentRecord, withKey: "appointmentReference")

                self?.cloudKitService.save(record: petRecord!) { result in
                    switch result {
                    case .success(_):
                        print("Appointment and Pet saved successfully")
                    case .failure(let error):
                        print("Error saving Appointment: \(error)")
                    }
                }

            case .failure(let error):
                print("Error saving Appointment: \(error)")
            }
        }
    }

}
