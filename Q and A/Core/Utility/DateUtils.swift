//
//  DateUtils.swift
//  Q and A
//
//  Created by GIGL-PC on 29/04/2026.
//

import Foundation


func isTimeInTheFuture(
    _ timeString: String,
    inputPattern: String = "dd-MM-yyyy HH:mm:ss"
) -> Bool {
    
    let formatter = DateFormatter()
    formatter.dateFormat = inputPattern
    formatter.locale = Locale(identifier: "en_US_POSIX")
    
    // Set timezone to UTC+1
    formatter.timeZone = TimeZone(secondsFromGMT: 1 * 3600)
    
    guard let inputDate = formatter.date(from: timeString) else {
        return false
    }
    
    return inputDate > Date()
}
