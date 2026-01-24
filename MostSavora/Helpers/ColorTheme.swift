//
//  ColorTheme.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import SwiftUI

struct ColorTheme {
    // Primary colors from the design spec
    static let primaryBackground = Color(hex: "003265")
    static let secondaryBackground = Color.white
    static let accentOrange = Color(hex: "f65505")
    
    // Derived colors for better UI
    static let lightBlue = Color(hex: "004080")
    static let darkBlue = Color(hex: "002040")
    static let lightOrange = Color(hex: "ff7733")
    
    // Text colors
    static let textPrimary = Color.white
    static let textSecondary = Color.gray
    static let textOnLight = Color.black
    
    // Card backgrounds
    static let cardBackground = Color.white
    static let cardBackgroundDark = Color(hex: "004080")
}

// Extension to create Color from hex string
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
