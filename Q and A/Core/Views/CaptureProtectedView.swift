//
//  CaptureProtectedView.swift
//  Q and A
//
//  Created by GIGL-PC on 26/08/2026.
//

import SwiftUI

struct CaptureProtectedView<Content: View>: View {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var monitor = ScreenCaptureMonitor()

    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            content
                .privacySensitive()

            if monitor.isCaptured || scenePhase != .active {
                protectionOverlay
                    .transition(.opacity)
                    .zIndex(100)
            }
        }
        .animation(.easeOut(duration: 0.15), value: monitor.isCaptured)
        .alert(
            "Screenshot Detected",
            isPresented: $monitor.screenshotWasTaken
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Please do not share sensitive content.")
        }
    }

    private var protectionOverlay: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 14) {
                Image(systemName: "eye.slash.fill")
                    .font(.system(size: 42))

                Text("Content Hidden")
                    .font(.headline)

                Text("This content is unavailable during screen recording or mirroring.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            .foregroundStyle(.white)
            .padding()
        }
    }
}
