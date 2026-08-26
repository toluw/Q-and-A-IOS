//
//  ShareSheetSuppressor.swift
//  Q and A
//
//  Created by GIGL-PC on 26/08/2026.
//

import Foundation
import UIKit

enum ShareSheetSuppressor {
    private static var isSwizzled = false
    static var isActive = false

    static func installOnce() {
        guard !isSwizzled else { return }
        isSwizzled = true

        let originalSelector = #selector(UIViewController.present(_:animated:completion:))
        let swizzledSelector = #selector(UIViewController.yt_swizzled_present(_:animated:completion:))

        guard
            let originalMethod = class_getInstanceMethod(UIViewController.self, originalSelector),
            let swizzledMethod = class_getInstanceMethod(UIViewController.self, swizzledSelector)
        else { return }

        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

extension Notification.Name {
    /// Posted whenever `ShareSheetSuppressor` swallows a share sheet, so
    /// interested views can show feedback instead of leaving the tap silent.
    static let shareSheetSuppressed = Notification.Name("shareSheetSuppressed")
}

private extension UIViewController {
    @objc func yt_swizzled_present(
        _ viewControllerToPresent: UIViewController,
        animated: Bool,
        completion: (() -> Void)?
    ) {
        if ShareSheetSuppressor.isActive, viewControllerToPresent is UIActivityViewController {
            #if DEBUG
            print("[ShareSheetSuppressor] Intercepted and swallowed a UIActivityViewController presentation.")
            #endif
            // Let any listening view show feedback instead of leaving the
            // tap silent — a reviewer or user tapping Share should see
            // *something* happen, even if it's "sharing isn't available."
            NotificationCenter.default.post(name: .shareSheetSuppressed, object: nil)
            // Swallow it entirely instead of presenting it.
            completion?()
            return
        }
        // Because of method_exchangeImplementations, this call actually
        // invokes the ORIGINAL `present(_:animated:completion:)`.
        self.yt_swizzled_present(viewControllerToPresent, animated: animated, completion: completion)
    }
}
