//
//  ScreenshotPreventingView.swift
//  Q and A
//
//  Created by GIGL-PC on 26/08/2026.
//

import SwiftUI
import UIKit

struct ScreenshotPreventingView<Content: View>: UIViewRepresentable {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func makeUIView(context: Context) -> UIView {
        let container = UIView()

        let secureField = UITextField()
        secureField.isSecureTextEntry = true
        secureField.isUserInteractionEnabled = false
        secureField.backgroundColor = .clear

        container.addSubview(secureField)

        secureField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            secureField.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            secureField.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            secureField.topAnchor.constraint(equalTo: container.topAnchor),
            secureField.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        let hostingController = UIHostingController(rootView: content)
        hostingController.view.backgroundColor = .clear

        secureField.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: secureField.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: secureField.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: secureField.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: secureField.bottomAnchor)
        ])

        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}


extension View {
    func preventScreenshots() -> some View {
        if ScreenshotProtection.shared.isEnabled {
            return AnyView(
                ScreenshotPreventingView {
                    self
                }
            )
        } else {
            return AnyView(self)
        }
    }
}
