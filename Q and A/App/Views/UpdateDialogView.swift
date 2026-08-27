//
//  UpdateDialogView.swift
//  Q and A
//
//  Created by GIGL-PC on 27/08/2026.
//

import SwiftUI

struct UpdateDialogView: View {
    let title: String
    let message: String
    let updateURL: URL
    let isForced: Bool
    var onDismiss: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "arrow.down.circle.fill")
                .font(.system(size: 48))
                .foregroundStyle(.blue)

            Text(title)
                .font(.headline)

            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            VStack(spacing: 12) {
                Button {
                    UIApplication.shared.open(updateURL)
                } label: {
                    Text("Update Now")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

                if !isForced {
                    Button("Not Now") {
                        onDismiss?()
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.secondary)
                }
            }
        }
        .padding(24)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
        .padding(32)
        .interactiveDismissDisabled(isForced)
    }
}

#Preview {
    UpdateDialogView(title: "Update", message: "New version available", updateURL: URL(filePath: "https//google.com")!, isForced: true)
}
