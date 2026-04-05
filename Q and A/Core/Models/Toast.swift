//
//  Toast.swift
//  Q and A
//
//  Created by GIGL-PC on 05/04/2026.
//

import Foundation

enum ToastType {
    case error
    case success
}

struct ToastData: Equatable {
    let message: String
    let type: ToastType
}
