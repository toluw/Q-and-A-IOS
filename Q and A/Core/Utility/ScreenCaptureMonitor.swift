//
//  ScreenCaptureMonitor.swift
//  Q and A
//
//  Created by GIGL-PC on 26/08/2026.
//

import SwiftUI
import UIKit
import Combine

@MainActor
final class ScreenCaptureMonitor: ObservableObject {
    @Published private(set) var isCaptured = UIScreen.main.isCaptured
    @Published var screenshotWasTaken = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        NotificationCenter.default.publisher(
            for: UIScreen.capturedDidChangeNotification
        )
        .receive(on: RunLoop.main)
        .sink { [weak self] notification in
            guard let self else { return }

            let screen = notification.object as? UIScreen
            self.isCaptured = screen?.isCaptured ?? UIScreen.main.isCaptured
        }
        .store(in: &cancellables)

        NotificationCenter.default.publisher(
            for: UIApplication.userDidTakeScreenshotNotification
        )
        .receive(on: RunLoop.main)
        .sink { [weak self] _ in
            // The screenshot has already been created at this point.
            self?.screenshotWasTaken = true
        }
        .store(in: &cancellables)
    }
}
