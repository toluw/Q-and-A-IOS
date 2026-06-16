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

func convertSecondsToFormattedTime(seconds: Int) -> String {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let remainingSeconds = seconds % 60

    var result = ""

    if hours > 0 {
        result += "\(hours)hr "
    }

    // Include minutes if there are hours, even if minutes is 0
    if minutes > 0 || hours > 0 {
        result += "\(minutes)m "
    }

    result += "\(remainingSeconds)s"

    return result.trimmingCharacters(in: .whitespaces)
}
