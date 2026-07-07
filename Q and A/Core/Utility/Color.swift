//
//  Color.swift
//  Q and A
//
//  Created by GIGL-PC on 07/07/2026.
//

import Foundation
import SwiftUI


extension Color {
    /// Creates a Color from a hex string like "#F1EFE8" or "F1EFE8".
    init(hex: String) {
        var sanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        sanitized = sanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: sanitized).scanHexInt64(&rgb)

        let r = Double((rgb & 0xFF0000) >> 16) / 255
        let g = Double((rgb & 0x00FF00) >> 8) / 255
        let b = Double(rgb & 0x0000FF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

/// Fixed light-mode palette. These are literal colors, not adaptive
/// system colors, so the screen looks the same regardless of the
/// device's Dark Mode setting.
enum LessonColor {
    static let surfaceWhite = Color(hex: "#FFFFFF")
    static let border = Color(hex: "#E3E1D9")

    static let textPrimary = Color(hex: "#1A1A18")
    static let textSecondary = Color(hex: "#5F5E5A")
    static let textMuted = Color(hex: "#888780")

    static let accentBg = Color(hex: "#E6F1FB")
    static let accentText = Color(hex: "#0C447C")

    static let dangerBg = Color(hex: "#FCEBEB")
    static let dangerText = Color(hex: "#A32D2D")

    static let itemBg = Color(hex: "#F1EFE8")

    static let videoThumbBg = Color(hex: "#8A7A1F")
    static let playBg = Color(hex: "#E24B4A")

    static let buttonBg = Color(hex: "#185FA5")
    static let buttonText = Color(hex: "#FFFFFF")
}
