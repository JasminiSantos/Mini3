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
    @Published var pdfDetails: [PDFDetails] = []
    @Published var filteredPdfDetails: [PDFDetails] = []
    @Published var veterinarian: Veterinarian
    
    @Published var petSearch: String = ""
    @Published var appointmentSearch: String = ""

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

}


