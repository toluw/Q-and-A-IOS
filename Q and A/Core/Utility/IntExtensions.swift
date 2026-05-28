//
//  IntExtensions.swift
//  Q and A
//
//  Created by GIGL-PC on 28/05/2026.
//

import Foundation

extension Int {
    
    func toHourString() -> String {
        switch self {
        case ..<60:
            return "\(self) min"
            
        default:
            if self % 60 == 0 {
                return "\(self / 60) hr"
            } else {
                return "\(self / 60) hr \(self % 60) min"
            }
        }
    }
}
