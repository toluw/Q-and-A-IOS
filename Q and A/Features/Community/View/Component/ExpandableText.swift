//
//  ExpandableText.swift
//  Q and A
//
//  Created by GIGL-PC on 14/07/2026.
//

import SwiftUI

struct ExpandableText: View {
    
    
    let content: String
    let postLimit: Int
    let isLinkify: Bool
    
    var body: some View {
        Text(displayText)
                .font(AppFont.regular(14))
    }
    
    private var displayText: AttributedString {
           if content.count > postLimit {
               var attributed = isLinkify
                   ? LinkifiedText.attributedString(text: String(content.prefix(postLimit)))
                   : AttributedString(String(content.prefix(postLimit)))

               attributed.append(AttributedString("... "))

               var readMore = AttributedString("Read more")
               readMore.foregroundColor = .blue

               attributed.append(readMore)

               return attributed
           } else {
               return isLinkify
                   ? LinkifiedText.attributedString(text: content)
                   : AttributedString(content)
           }
       }
}

#Preview {
    ExpandableText(content: "Visit https://www.apple.com or http://google.com for more information.", postLimit: 100, isLinkify: true)
}
