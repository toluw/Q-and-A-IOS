//
//  RowButtonStyle.swift
//  Q and A
//
//  Created by GIGL-PC on 07/07/2026.
//

import Foundation
import SwiftUI


struct RowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}
