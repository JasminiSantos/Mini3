//
//  CondicaoCorporal.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 31/10/23.
//

import Foundation

enum CondicaoCorporal: Int, CaseIterable {
    case muitoMagro1 = 1
    case muitoMagro2 = 2
    case muitoMagro3 = 3
    case ideal4 = 4
    case ideal5 = 5
    case acimaDoIdeal = 6
    case sobrepeso = 7
    case obeso8 = 8
    case obeso9 = 9
    
    var description: String {
        switch self {
        case .muitoMagro1, .muitoMagro2, .muitoMagro3:
            return "Muito magro"
        case .ideal4, .ideal5:
            return "Ideal"
        case .acimaDoIdeal:
            return "Acima do ideal"
        case .sobrepeso:
            return "Sobrepeso"
        case .obeso8, .obeso9:
            return "Obeso"
        }
    }
    
    var classification: String {
        return "\(self.rawValue) - \(self.description)"
    }
}
