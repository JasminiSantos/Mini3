//
//  PetOwner.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 09/11/23.
//

import SwiftUI

struct PetOwner {
    var name: String
    var cpf: String
    var phoneNumber: String
    var address: String
    var email: String
}

class PetOwnerModel: ObservableObject {
    @Published var name: String
    @Published var cpf: String
    @Published var phoneNumber: String
    @Published var address: String
    @Published var email: String
    
    init(name: String, cpf: String, phoneNumber: String, address: String, email: String) {
        self.name = name
        self.cpf = cpf
        self.phoneNumber = phoneNumber
        self.address = address
        self.email = email
    }
}
