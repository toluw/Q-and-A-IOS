//
//  UpdateStatus.swift
//  Q and A
//
//  Created by GIGL-PC on 27/08/2026.
//

import Foundation

enum UpdateStatus: Equatable {
    case none
    case optional(message: String, url: URL)
    case forced(message: String, url: URL)
}
