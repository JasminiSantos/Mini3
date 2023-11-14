//
//  Veterinarian.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 02/11/23.
//

import SwiftUI
import Combine
import CloudKit

class Veterinarian: ObservableObject, Identifiable, Codable {
    var id: UUID = UUID()
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var crmv: String = ""
    @Published var cpf: String = ""
    @Published var phoneNumber: String = ""
    var signatureUrl: String = ""

    init(id: UUID,name: String = "", email: String = "", crmv: String = "", cpf: String = "", phoneNumber: String = "", signatureUrl: String = "") {
        self.id = id
        self.name = name
        self.email = email
        self.crmv = crmv
        self.cpf = cpf
        self.phoneNumber = phoneNumber
        self.signatureUrl = signatureUrl
    }

    enum CodingKeys: CodingKey {
        case id, name, email, crmv, cpf, phoneNumber, signatureUrl
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
//        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        crmv = try container.decode(String.self, forKey: .crmv)
        cpf = try container.decode(String.self, forKey: .cpf)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        signatureUrl = try container.decode(String.self, forKey: .signatureUrl)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
//        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(crmv, forKey: .crmv)
        try container.encode(cpf, forKey: .cpf)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(signatureUrl, forKey: .signatureUrl)
    }
}
