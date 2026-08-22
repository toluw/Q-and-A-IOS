//
//  ComingSoonConfig.swift
//  Q and A
//
//  Created by GIGL-PC on 22/08/2026.
//

import Foundation
import SwiftUI


struct ComingSoonConfig {
    var icon: String = "hourglass"
    var title: String = "Coming Soon"
    var message: String = "We're working hard to bring you this feature. Stay tuned!"
    var accentColor: Color = .accentColor
    var showNotifyButton: Bool = false
    var onNotifyTapped: (() -> Void)? = nil

    static let `default` = ComingSoonConfig()
}
