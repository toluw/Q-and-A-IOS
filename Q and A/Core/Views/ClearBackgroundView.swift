//
//  ClearBackgroundView.swift
//  Q and A
//
//  Created by GIGL-PC on 27/08/2026.
//

import SwiftUI

struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .black.withAlphaComponent(0.4)
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}


