//
//  CustomColor.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 31/10/23.
//

import SwiftUI

enum CustomColor {
    static var customDarkBlue: Color {
        return Color("CustomDarkBlue")
    }
    static var customOrange: Color {
        return Color("CustomOrange")
    }
    static var customMint: Color {
        return Color("CustomMint")
    }
    static var customLightBlue: Color {
        return Color("CustomLightBlue")
    }
    static var customLightBlue2: Color {
        return Color("CustomLightBlue2")
    }
    static var customBlue: Color {
        return Color("CustomBlue")
    }
    static var customGray: Color {
        return Color("CustomGray")
    }
    static var customGray2: Color {
        return Color(hex: "D9D9D9")
    }
    static var customPaletteBlue: Color {
        return Color(hex: "6B9AC4")
    }
    static var customPaletteGreen: Color {
        return Color(hex: "1B9179")
    }
    static var customPaletteYellow: Color {
        return Color(hex: "F4B942")
    }
    static var customPaletteRed: Color {
        return Color(hex: "D13030")
    }
    
    static var customGreen: Color {
        return Color(hex: "74C69D")
    }
    static var customDarkBlue2: Color {
        return Color(hex: "003559")
    }
    static var customLightOrange: Color {
        return Color(hex: "FCEAC6")
    }
    
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0

        scanner.scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
