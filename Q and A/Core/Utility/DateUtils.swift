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

extension TimeInterval {
    func toTimeFormat() -> String {
        let totalSeconds = Int(max(0, self))
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else if(minutes > 0 ) {
            return String(format: "%02d:%02d", minutes, seconds)
        } else {
            return String(format: "%02d",seconds)
        }
    }
}

func getCurrentTime() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter.string(from: Date())
}

func getTimeDifferenceInSeconds(
    _ pastTimeString: String,
    inputPattern: String = "yyyy-MM-dd HH:mm:ss"
) throws -> Int {

    let formatter = DateFormatter()
    formatter.dateFormat = inputPattern
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone.current

    guard let pastDate = formatter.date(from: pastTimeString) else {
        throw NSError(
            domain: "DateParsing",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "Invalid date format"]
        )
    }

    let currentDate = Date()

    return Int(currentDate.timeIntervalSince(pastDate))
}

func convertSecondsToMinutes(seconds: Int) -> Int {
    return seconds / 60
}

func convertSecondsToHours(seconds: Int) -> Int {
    return seconds / 3600
}

func convertSecondsToDays(seconds: Int) -> Int {
    return seconds / 86400 // 1 day = 86400 seconds
}

func getPatternFromDate(
    date: String,
    outputPattern: String = "MMM dd, yyyy",
    inputPattern: String = "yyyy-MM-dd HH:mm:ss"
) -> String {

    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = inputPattern
    inputFormatter.locale = Locale(identifier: "en_US_POSIX")

    guard let parsedDate = inputFormatter.date(from: date) else {
        return ""
    }

    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = outputPattern
    outputFormatter.locale = Locale.current

    return outputFormatter.string(from: parsedDate)
}

func getTimeDifference(
    pastTime: String,
    inputPattern: String = "yyyy-MM-dd HH:mm:ss"
) -> String {
    
    do{
       
        let timeDiffSec = try getTimeDifferenceInSeconds(
            pastTime,
            inputPattern: inputPattern
        )

        switch timeDiffSec {
        case ..<60:
            return "now"
        case ..<3600:
            return "\(convertSecondsToMinutes(seconds: timeDiffSec))m"
        case ..<86400:
            return "\(convertSecondsToHours(seconds: timeDiffSec))h"
        case ..<2_592_000:
            return "\(convertSecondsToDays(seconds: timeDiffSec))d"
        case ..<31_104_000:
            return getPatternFromDate(
                date: pastTime,
                outputPattern: "dd MMM",
                inputPattern: inputPattern
            )
        default:
            return getPatternFromDate(
                date: pastTime,
                outputPattern: "dd MMM yyyy",
                inputPattern: inputPattern
            )
        }
        
    }catch{
        return ""
    }

   
}


