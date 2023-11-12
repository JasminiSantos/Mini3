//
//  PetProfileViewModel.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 09/11/23.
//

import SwiftUI

class PetProfileViewModel: ObservableObject {
    @Published var search: String = ""
    @Published var pet: PetModel
    @Published var petOwner: PetOwnerModel
    @Published var selectedCharacter = AccountCharacter.pet.rawValue
    
    let allPetGenders = PetGender.allCases.map { $0.rawValue }
    let allSpecies = Specie.allCases.map { $0.rawValue }
    let allCharacters = AccountCharacter.allCases.map { (id: $0.rawValue, name: $0.description) }
    @Published var selectedGender: String = PetGender.male.rawValue
    @Published var selectedSpecie: String = Specie.felino.rawValue
    @Published var currentState: State = .creating
    
    init(pet: PetModel, petOwner: PetOwnerModel) {
        self.pet = pet
        self.petOwner = petOwner
    }
    
    enum State {
        case creating
        case editing
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

