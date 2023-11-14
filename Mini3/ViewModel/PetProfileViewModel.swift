//
//  PetProfileViewModel.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 09/11/23.
//

import SwiftUI
import CloudKit

class PetProfileViewModel: ObservableObject {
    @Published var search: String = ""
    
    @Published var pet: Pet = Pet(id: UUID(),name: "", specie: "", breed: "", age: "", gender: "", furColor: "")
    @Published var petOwner: PetOwner = PetOwner(id: UUID(), name: "", cpf: "", phoneNumber: "", address: "", email: "")
    @Published var veterinarian: Veterinarian = Veterinarian(id: UUID(), name: "", email:"", crmv: "", cpf: "", phoneNumber: "", signatureUrl: "")
    
    @Published var selectedCharacter = AccountCharacter.pet.rawValue
    
    let allPetGenders = PetGender.allCases.map { $0.rawValue }
    let allSpecies = Specie.allCases.map { $0.rawValue }
    let allCharacters = AccountCharacter.allCases.map { (id: $0.rawValue, name: $0.description) }
    @Published var selectedGender: String = PetGender.male.rawValue
    @Published var selectedSpecie: String = Specie.felino.rawValue
    @Published var selectedImage: UIImage?
    @Published var currentState: State = .creating
    
    let cloudKitService = CloudKitService()
    
    @Published var alertMessage: String?
    @Published var showAlert: Bool = false
                                       
   init(){}
    
    init(pet: Pet, petOwner: PetOwner, veterinarian: Veterinarian) {
        self.pet = pet
        self.petOwner = petOwner
        self.veterinarian = veterinarian
    }
    

    enum State {
        case creating
        case editing
    }
    
    func savePetAndOwner() {
        pet.specie = selectedSpecie
        pet.gender = selectedGender
        
        let petOwnerErrors = petOwner.validationErrors()
        let petErrors = pet.validationErrors()
        
        let allErrors = petErrors + petOwnerErrors
        
        if !allErrors.isEmpty {
            alertMessage = errorString(from: allErrors)
            showAlert = true
            return
        }
        guard pet.isValid else {
            print("Pet data is not valid.")
            return
        }
        
        guard petOwner.isValid else {
            print("Pet Owner data is not valid.")
            return
        }
        
        petOwner.cpf = petOwner.sanitizedCPF
        
        let petOwnerRecord = petOwner.asCKRecord
        cloudKitService.save(record: petOwnerRecord) { [weak self] result in
            switch result {
            case .success(let savedOwnerRecord):
                let petRecord = self?.pet.asCKRecord
                
                self?.cloudKitService.createReference(from: savedOwnerRecord, to: petRecord!, withKey: "ownerReference")
                
                self?.cloudKitService.save(record: petRecord!) { result in
                    switch result {
                    case .success(_):
                        print("Both Pet and PetOwner saved successfully")
                    case .failure(let error):
                        print("Error saving Pet: \(error)")
                    }
                }
                
            case .failure(let error):
                print("Error saving PetOwner: \(error)")
            }
        }
    }
    
    func updatePet() {
        pet.specie = selectedSpecie
        pet.gender = selectedGender
        
        guard pet.isValid else {
            print("Pet data is not valid.")
            return
        }

        var updatedData: [String: CKRecordValue] = [:]

        updatedData["name"] = pet.name as CKRecordValue
        updatedData["specie"] = pet.specie as CKRecordValue
        updatedData["breed"] = pet.breed as CKRecordValue
        updatedData["age"] = pet.age as CKRecordValue
        updatedData["gender"] = pet.gender as CKRecordValue
        updatedData["furColor"] = pet.furColor as CKRecordValue
        
        if let image = selectedImage, let imageData = image.pngData() {
            let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
            let fileURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
            do {
                try imageData.write(to: fileURL)
                updatedData["image"] = CKAsset(fileURL: fileURL)
            } catch {
                print("Error writing updated image data to temp file: \(error)")
                return
            }
        }

        let ckPetRecordID = CKRecord.ID(recordName: pet.id.uuidString)
        cloudKitService.updateRecord(recordType: "Pet", key: "id", recordID: pet.id, updatedData: updatedData) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error updating Pet: \(error)")
                } else {
                    print("Pet updated successfully")
                }
            }
        }
    }
    
    func updatePetOwner() {
        guard petOwner.isValid else {
            print("Pet Owner data is not valid.")
            return
        }
        
        petOwner.cpf = petOwner.sanitizedCPF
        
        var updatedData: [String: CKRecordValue] = [:]

        updatedData["name"] = petOwner.name as CKRecordValue
        updatedData["cpf"] = petOwner.cpf as CKRecordValue
        updatedData["phoneNumber"] = petOwner.phoneNumber as CKRecordValue
        updatedData["address"] = petOwner.address as CKRecordValue
        updatedData["email"] = petOwner.email as CKRecordValue

        let ckPetOwnerRecordID = CKRecord.ID(recordName: petOwner.id.uuidString)
        cloudKitService.updateRecord(recordType: "PetOwner", key: "id", recordID: petOwner.id, updatedData: updatedData) { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.alertMessage = "Error updating cookbook. Please, try again!"
//                    self.isSuccess = false
                    print("Error updating pet owner: \(error)")
                } else {
                    self.alertMessage = "Successfully updated pet owner!"
//                    self.isSuccess = true
                    print("Successfully updated pet owner!")
                }
                self.showAlert = true
//                self.requestInProgress = false
            }

        }
    }

    
    private func errorString(from errors: [String]) -> String {
        "Please correct the following errors:\n" + errors.joined(separator: "\n")
    }
    
}

enum AccountCharacter: Int, CaseIterable, Hashable {
    case pet = 1
    case owner = 2
    
    var description: String {
        switch self {
        case .pet:
            return "Dados do Pet"
        case .owner:
            return "Dados do Tutor"
        }
    }
}

