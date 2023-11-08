//
//  Pet.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 02/11/23.
//

import SwiftUI

struct Pet: Codable {
    var name: String
    var species: String
    var breed: String
    var age: String
    var gender: String
    var furColor: String
    var tutor: String
    var cpf: String
    var address: String
}
class PetModel: ObservableObject {
    @Published var name: String
    @Published var species: String
    @Published var breed: String
    @Published var age: String
    @Published var gender: String
    @Published var furColor: String
    @Published var tutor: String
    @Published var cpf: String
    @Published var address: String
    
    init(name: String, species: String, breed: String, age: String, gender: String, furColor: String, tutor: String, cpf: String, address: String) {
        self.name = name
        self.species = species
        self.breed = breed
        self.age = age
        self.gender = gender
        self.furColor = furColor
        self.tutor = tutor
        self.cpf = cpf
        self.address = address
    }
}
