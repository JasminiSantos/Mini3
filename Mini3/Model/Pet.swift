//
//  Pet.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 02/11/23.
//

import SwiftUI
import CloudKit
import Combine

class Pet: ObservableObject, Identifiable, Codable {
    var id: UUID = UUID()
    @Published var name: String = ""
    @Published var specie: String = ""
    @Published var breed: String = ""
    @Published var age: String = ""
    @Published var gender: String = ""
    @Published var furColor: String = ""
    @Published var image: String = ""
    
    init(id: UUID, name: String = "", specie: String = "", breed: String = "", age: String = "", gender: String = "", furColor: String = "", img: String = "") {
        self.id = id
        self.name = name
        self.specie = specie
        self.breed = breed
        self.age = age
        self.gender = gender
        self.furColor = furColor
        self.image = image
    }
    
    enum CodingKeys: CodingKey {
        case name, specie, breed, age, gender, furColor, image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        specie = try container.decode(String.self, forKey: .specie)
        breed = try container.decode(String.self, forKey: .breed)
        age = try container.decode(String.self, forKey: .age)
        gender = try container.decode(String.self, forKey: .gender)
        furColor = try container.decode(String.self, forKey: .furColor)
        image = try container.decode(String.self, forKey: .image)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(specie, forKey: .specie)
        try container.encode(breed, forKey: .breed)
        try container.encode(age, forKey: .age)
        try container.encode(gender, forKey: .gender)
        try container.encode(furColor, forKey: .furColor)
        try container.encode(image, forKey: .image)
    }
}

enum PetGender: String, CaseIterable, Codable {
    case male = "Macho"
    case female = "Fêmea"
    case unknown = "Desconhecido"
}

extension Pet {
    var asCKRecord: CKRecord {
        let record = CKRecord(recordType: "Pet")
        record.setValue(id.uuidString, forKey: "id")
        record.setValue(name, forKey: "name")
        record.setValue(specie, forKey: "specie")
        record.setValue(breed, forKey: "breed")
        record.setValue(age, forKey: "age")
        record.setValue(gender, forKey: "gender")
        record.setValue(furColor, forKey: "furColor")
        record.setValue(image, forKey: "image")
        return record
    }
    
    var isValid: Bool {
        return validationErrors().isEmpty
    }
    func validationErrors() -> [String] {
        var errors = [String]()
        
        if name.isEmpty {
            errors.append("Name cannot be empty.")
        }
        if specie.isEmpty {
            errors.append("Specie cannot be empty.")
        }
        if breed.isEmpty {
            errors.append("Breed cannot be empty.")
        }
        if age.isEmpty {
            errors.append("Age cannot be empty.")
        }
        if gender.isEmpty {
            errors.append("Gender cannot be empty.")
        }
        if furColor.isEmpty {
            errors.append("Fur Color cannot be empty.")
        }
        
        return errors
    }
}
