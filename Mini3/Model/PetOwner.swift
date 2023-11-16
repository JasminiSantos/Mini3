//
//  PetOwner.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 09/11/23.
//

import SwiftUI
import CloudKit

class PetOwner: ObservableObject, Identifiable, Codable {
    var id: UUID = UUID()
    @Published var name: String = ""
    @Published var cpf: String = ""
    @Published var phoneNumber: String = ""
    @Published var address: String = ""
    @Published var email: String = ""
    
    init(id: UUID,name: String = "", cpf: String = "", phoneNumber: String = "", address: String = "", email: String = "") {
        self.id = id
        self.name = name
        self.cpf = cpf
        self.phoneNumber = phoneNumber
        self.address = address
        self.email = email
    }
    
    enum CodingKeys: CodingKey {
        case name, cpf, phoneNumber, address, email
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        cpf = try container.decode(String.self, forKey: .cpf)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        address = try container.decode(String.self, forKey: .address)
        email = try container.decode(String.self, forKey: .email)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(cpf, forKey: .cpf)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(address, forKey: .address)
        try container.encode(email, forKey: .email)
    }
    
    func update(from other: PetOwner) {
        name = other.name
        cpf = other.cpf
        phoneNumber = other.phoneNumber
        address = other.address
        email = other.email
    }
}

extension PetOwner {
    var asCKRecord: CKRecord {
        let record = CKRecord(recordType: "PetOwner")
        record.setValue(id.uuidString, forKey: "id")
        record.setValue(name, forKey: "name")
        record.setValue(cpf, forKey: "cpf")
        record.setValue(address, forKey: "address")
        record.setValue(email, forKey: "email")
        record.setValue(phoneNumber, forKey: "phoneNumber")
        return record
    }
    
    var sanitizedCPF: String {
        return cpf.filter(\.isNumber)
    }
    
    var isValid: Bool {
        return validationErrors().isEmpty
    }
    
    func validationErrors() -> [String] {
        var errors = [String]()
        
        if name.isEmpty {
            errors.append("Name cannot be empty.")
        }
        if sanitizedCPF.count != 11 {
            errors.append("CPF must have 11 digits.")
        }
        if phoneNumber.count < 8 {
            errors.append("Phone number must be at least 8 digits.")
        }
        if address.isEmpty {
            errors.append("Address cannot be empty.")
        }
        if !email.contains("@") || !email.contains(".") {
            errors.append("Email must be valid.")
        }
        
        return errors
    }
}
