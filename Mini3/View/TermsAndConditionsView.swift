//
//  TermsAndConditionsView.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 10/11/23.
//

import SwiftUI

struct TermsAndConditionsView: View {
    @State var errorMessage: String? = ""
    
    var body: some View {
        VStack {
            WebView(url: URL(string: "https://vetpad.notion.site/vetpad/Termos-e-Condi-es-Gerais-de-Uso-do-aplicativo-VETPAD-53da2232b4a2441f8b3ce4b68e5834e2")!, errorMessage: $errorMessage)
                .navigationBarTitle("Termos e Condições", displayMode: .inline)
        }
    }
}

