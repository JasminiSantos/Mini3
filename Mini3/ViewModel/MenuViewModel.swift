//
//  MenuViewModel.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 09/11/23.
//

import SwiftUI
import PDFKit
import CloudKit

@MainActor
class MenuViewModel: ObservableObject {
    private let cloudKitService = CloudKitService()
    
    @Published var originalPetsWithOwners: [(pet: Pet, owner: PetOwner?)] = []
    @Published var petsWithOwners: [(pet: Pet, owner: PetOwner?)] = []
    @Published var originalPDFDetails: [PDFDetails] = []
    @Published var filteredPDFDetails: [PDFDetails] = []
    @Published var veterinarian: Veterinarian
    
    @Published var petSearch: String = ""
    @Published var appointmentSearch: String = ""
    
    @Published var isLoading: Bool = true

    init(veterinarian: Veterinarian) {
        self.veterinarian = veterinarian
    }

    func fetchPetData() {
        let recordType = "Pet"
        cloudKitService.fetchRecords(recordType: recordType) { [weak self] records, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("An error occurred while fetching pets: \(error)")
                    return
                }
                guard let records = records else { return }
                
                var tempPetsWithOwners: [(pet: Pet, owner: PetOwner?)] = []
                
                let dispatchGroup = DispatchGroup()
                
                for record in records {
                    dispatchGroup.enter()
                    
                    guard let pet = self?.createPet(from: record) else {
                        dispatchGroup.leave()
                        continue
                    }
                    
                    if let ownerReference = record["ownerReference"] as? CKRecord.Reference {
                        self?.cloudKitService.fetchRecord(withID: ownerReference.recordID) { result in
                            var petOwner: PetOwner?
                            if case .success(let ownerRecord) = result {
                                petOwner = self?.createPetOwner(from: ownerRecord)
                            } else if case .failure(let error) = result {
                                print("Error fetching pet owner: \(error)")
                            }
                            tempPetsWithOwners.append((pet: pet, owner: petOwner))
                            dispatchGroup.leave()
                        }
                    } else {
                        tempPetsWithOwners.append((pet: pet, owner: nil))
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    self?.petsWithOwners = tempPetsWithOwners
                    self?.originalPetsWithOwners = tempPetsWithOwners
                }
            }
        }
    }

    func filterPets() {
        if petSearch.isEmpty {
            petsWithOwners = originalPetsWithOwners
        } else {
            petsWithOwners = originalPetsWithOwners.filter { petWithDetails in
                let pet = petWithDetails.pet
                return pet.name.lowercased().contains(petSearch.lowercased())
            }
        }
    }
    
    func filterPDFs() {
        if appointmentSearch.isEmpty {
            filteredPDFDetails = originalPDFDetails
        } else {
            filteredPDFDetails = originalPDFDetails.filter { pdfDetail in
                return pdfDetail.pet.name.lowercased().contains(appointmentSearch.lowercased())
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
    
    func createPetOwner(from record: CKRecord) -> PetOwner? {
        guard let id = record["id"] as? String,
              let name = record["name"] as? String,
              let cpf = record["cpf"] as? String,
              let phoneNumber = record["phoneNumber"] as? String,
              let address = record["address"] as? String,
              let email = record["email"] as? String else {
            print("Failed to process pet owner record: \(record)")
            return nil
        }
        
        return PetOwner(id: UUID(uuidString: id)! ,name: name, cpf: cpf, phoneNumber: phoneNumber, address: address, email: email)
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
    
    func fetchAllPDFs(forPetID petID: UUID? = nil) {
        self.isLoading = true
        let recordType = "PDF"
        cloudKitService.fetchRecords(recordType: recordType) { [weak self] records, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("An error occurred while fetching PDFs: \(error)")
                    self?.isLoading = false
                    return
                }
                guard let records = records else { return }

                var pdfDetailsArray: [PDFDetails] = []
                let dispatchGroup = DispatchGroup()

                for record in records {
                    dispatchGroup.enter()
                    self?.processPDFRecord(record) { pdfDetails in
                        if let details = pdfDetails {
                            pdfDetailsArray.append(details)
                        }
                        dispatchGroup.leave()
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    var filteredPDFDetails: [PDFDetails] = []

                    if let petID = petID {
                        for details in pdfDetailsArray {
                            if details.pet.id == petID {
                                filteredPDFDetails.append(details)
                            }
                        }
                        self?.filteredPDFDetails = filteredPDFDetails
                    } else {
                        filteredPDFDetails = pdfDetailsArray
                    }
                    
                    self?.filteredPDFDetails = filteredPDFDetails
                    self?.originalPDFDetails = filteredPDFDetails
                    self?.isLoading = false
                }


            }
        }
    }
    
    private func processPDFRecord(_ record: CKRecord, completion: @escaping (PDFDetails?) -> Void) {
        guard let pdfAsset = record["pdfFile"] as? CKAsset,
              let fileURL = pdfAsset.fileURL else {
            print("Failed to process PDF record: \(record)")
            completion(nil)
            return
        }

        let timestamp = record.creationDate ?? Date()

        if let petReference = record["petReference"] as? CKRecord.Reference {
            cloudKitService.fetchRecord(withID: petReference.recordID) { [weak self] result in
                switch result {
                case .success(let petRecord):
                    let pet = self?.createPet(from: petRecord)
                    
                    if let ownerReference = petRecord["ownerReference"] as? CKRecord.Reference {
                        self?.cloudKitService.fetchRecord(withID: ownerReference.recordID) { ownerResult in
                            DispatchQueue.main.async {
                                switch ownerResult {
                                case .success(let ownerRecord):
                                    let petOwner = self?.createPetOwner(from: ownerRecord)
                                    completion(PDFDetails(pdfURL: fileURL, timestamp: timestamp, pet: pet!, petOwner: petOwner))
                                case .failure(let error):
                                    print("Error fetching pet owner record: \(error)")
                                    self?.isLoading = false
                                    completion(nil)
                                }
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(PDFDetails(pdfURL: fileURL, timestamp: timestamp, pet: pet!, petOwner: nil))
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        print("Error fetching pet record: \(error)")
                        self?.isLoading = false
                        completion(nil)
                    }
                }
            }
        }
    }


}
struct PDFDetails {
    let id: UUID = UUID()
    var pdfURL: URL
    var timestamp: Date
    var pet: Pet
    var petOwner: PetOwner?
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "dd MMM 'de' yyyy"
        return dateFormatter.string(from: timestamp)
    }

    var formattedTime: String {
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "pt_BR")
        timeFormatter.dateFormat = "HH:mm"
        return timeFormatter.string(from: timestamp)
    }
}
