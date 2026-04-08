//
//  BottomSheetData.swift
//  Q and A
//
//  Created by GIGL-PC on 08/04/2026.
//

import Foundation

enum BottomSheetType {
    case error
    case success
}

struct BottomSheetData: Identifiable, Equatable {
    
    let id = UUID()
    let type: BottomSheetType
    let message: String
    let actionTitle: String?
    let action: () -> Void
    
    static func == (lhs: BottomSheetData, rhs: BottomSheetData) -> Bool {
           return lhs.id == rhs.id &&
                  lhs.type == rhs.type &&
                  lhs.message == rhs.message &&
                  lhs.actionTitle == rhs.actionTitle
           // 🔥 ignore action
       }
}
