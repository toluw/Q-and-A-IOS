//
//  LinkifiedText.swift
//  Q and A
//
//  Created by GIGL-PC on 23/07/2026.
//

import SwiftUI

struct LinkifiedText {
    
    
      
    
    
    
    static func attributedString(
        text: String,
        textColor: Color = .black
    ) -> AttributedString {
           var attributed = AttributedString(text)

           // Set default color for all text
           attributed.foregroundColor = textColor

           guard let detector = try? NSDataDetector(
               types: NSTextCheckingResult.CheckingType.link.rawValue
           ) else {
               return attributed
           }

           let matches = detector.matches(
               in: text,
               range: NSRange(location: 0, length: text.utf16.count)
           )

           for match in matches {
               guard
                   let url = match.url,
                   let range = Range(match.range, in: attributed)
               else {
                   continue
               }

               attributed[range].link = url
               attributed[range].foregroundColor = .blue
               attributed[range].underlineStyle = .single
           }

           return attributed
       }
}

