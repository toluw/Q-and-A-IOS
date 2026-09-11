//
//  NotificationPrimerModifier.swift
//  Q and A
//
//  Created by GIGL-PC on 01/09/2026.
//
import SwiftUI

/// Attaches the notification-priming alert to any view. Apply once, at the
/// app root, so every call to `presentPrimerIfNeeded(for:)` anywhere in the
/// app surfaces through this single dialog.
struct NotificationPrimerModifier: ViewModifier {
    @ObservedObject private var notificationManager = NotificationManager.shared

    func body(content: Content) -> some View {
        content
            .alert(
                item: $notificationManager.presentedPrimerReason
            ) { reason in
                Alert(
                    title: Text(reason.title),
                    message: Text(reason.message),
                    primaryButton: .default(Text(reason.confirmActionTitle)) {
                        notificationManager.confirmPrimerRequest()
                    },
                    secondaryButton: .cancel(Text("Not Now")) {
                        notificationManager.dismissPrimer()
                    }
                )
            }
    }
}

extension View {
    /// Enables the notification-priming dialog for this view subtree.
    /// Apply once at the root of the app.
    func notificationPrimer() -> some View {
        modifier(NotificationPrimerModifier())
    }
}
