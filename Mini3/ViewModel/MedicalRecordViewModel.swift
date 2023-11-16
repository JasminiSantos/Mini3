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
    @Published var pdfUrl: URL?
    
    @Published var submissionState: AppointmentSubmissionState = .none
    @Published var isLoading: Bool = true
    
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
    
    func convertPDFToData(from url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            print("Error converting PDF to data: \(error)")
            submissionState = .error
            return nil
        }
    }
    func writeToTemporaryFile(_ data: Data) -> URL? {
        let tempDirURL = FileManager.default.temporaryDirectory
        let fileURL = tempDirURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("pdf")

        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Error writing data to temporary file: \(error)")
            return nil
        }
    }

    func savePDFToCloudKit(pdfURL: URL, completion: @escaping (Error?) -> Void) {
        guard let pdfData = convertPDFToData(from: pdfURL),
              let tempURL = writeToTemporaryFile(pdfData) else {
            completion(NSError(domain: "AppDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to process PDF file"]))
            return
        }
        
        let pdfAsset = CKAsset(fileURL: tempURL)
        
        let ckPetRecordID = CKRecord.ID(recordName: pet.id.uuidString)
        
        let pdfRecord = CKRecord(recordType: "PDF")
        
        pdfRecord["pdfFile"] = pdfAsset
        pdfRecord["appointmentTimestamp"] = NSNumber(value: Date().timeIntervalSince1970)
        
        let predicate = NSPredicate(format: "id == %@", pet.id.uuidString)
        cloudKitService.fetchRecords(recordType: "Pet", predicate: predicate) { records, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching pet record: \(error)")
                    completion(nil)
                } else if let records = records, var petRecord = records.first {
                    self.cloudKitService.createReference(from: petRecord, to: pdfRecord, withKey: "petReference")
                    self.cloudKitService.save(record: pdfRecord) { saveResult in
                        DispatchQueue.main.async {
                            switch saveResult {
                            case .success:
                                self.submissionState = .success
                                print("PDF record saved successfully")
                                completion(nil)
                            case .failure(let error):
                                self.submissionState = .error
                                print("Error saving PDF record: \(error)")
                                completion(error)
                            }
                            try? FileManager.default.removeItem(at: tempURL)
                        }
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    private func createPet(from record: CKRecord) -> Pet? {
        guard let idString = record["id"] as? String,
              let id = UUID(uuidString: idString),
              let name = record["name"] as? String,
              let specie = record["specie"] as? String,
              let breed = record["breed"] as? String,
              let age = record["age"] as? String,
              let gender = record["gender"] as? String,
              let furColor = record["furColor"] as? String else {
            print("Failed to process pet record: \(record)")
            return nil
        }
        
        return Pet(id: UUID(uuidString: idString)!,name: name, specie: specie, breed: breed, age: age, gender: gender, furColor: furColor)
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

}

enum AppointmentSubmissionState {
    case success
    case error
    case none
}
