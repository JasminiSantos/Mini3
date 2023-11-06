//
//  RegisterType.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 31/10/23.
//

import Foundation

enum RegisterType: Int, CaseIterable, Hashable {
    case motivoAnamnese = 1
    case observacoes = 2
    case tratamento = 3
    
    var description: String {
        switch self {
        case .motivoAnamnese:
            return "Motivo/Anamnese"
        case .observacoes:
            return "Observações"
        case .tratamento:
            return "Tratamento"
        }
    }
}
