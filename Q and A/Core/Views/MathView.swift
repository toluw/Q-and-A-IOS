//
//  MathView.swift
//  Q and A
//
//  Created by GIGL-PC on 24/06/2026.
//

import Foundation

import SwiftUI
import SwiftMath

struct MathView: UIViewRepresentable {

    let latex: String

    func makeUIView(context: Context) -> MTMathUILabel {
        let label = MTMathUILabel()

        label.textAlignment = .left
        label.labelMode = .text
        label.fontSize = 18

        return label
    }

    func updateUIView(
        _ uiView: MTMathUILabel,
        context: Context
    ) {
        uiView.latex = latex
    }
}
