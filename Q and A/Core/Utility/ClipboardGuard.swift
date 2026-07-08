//
//  ClipboardGuard.swift
//  Q and A
//
//  Created by GIGL-PC on 08/07/2026.
//

import Foundation
import UIKit


@MainActor
final class ClipboardGuard {
    private var observer: NSObjectProtocol?
    private var isClearing = false
 
    func start() {
        guard observer == nil else { return }
        observer = NotificationCenter.default.addObserver(
            forName: UIPasteboard.changedNotification,
            object: UIPasteboard.general,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor [weak self] in
                guard let self, !self.isClearing else { return }
                self.isClearing = true
                UIPasteboard.general.string = ""
                self.isClearing = false
            }
        }
    }
 
    func stop() {
        if let observer {
            NotificationCenter.default.removeObserver(observer)
        }
        observer = nil
    }
}
 
