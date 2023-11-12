//
//  Veterinarian.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 02/11/23.
//

import SwiftUI

struct Veterinarian: Codable, Identifiable, Hashable {
    let id: UUID
    var name: String
    var email: String
    var crmv: String
    var cpf: String
    var phoneNumber: String
    let signatureUrl: String
}

class VeterinarianModel: ObservableObject {
    @Published var name: String
    @Published var email: String
    @Published var crmv: String
    @Published var phoneNumber: String
//    @Published var cpf: String
//    @Published var signatureUrl: String
    
//    init(name: String, email: String, crmv: String, phoneNumber: String, cpf: String, signatureUrl: String) {
//        self.name = name
//        self.email = email
//        self.crmv = crmv
//        self.phoneNumber = phoneNumber
//        self.cpf = cpf
//        self.signatureUrl = signatureUrl
//    }
    init(name: String, email: String, crmv: String, phoneNumber: String) {
        self.name = name
        self.email = email
        self.crmv = crmv
        self.phoneNumber = phoneNumber
    }
}
