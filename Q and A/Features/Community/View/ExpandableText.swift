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
    
    var body: some View {
        Group {
                if content.count > postLimit {
                    Text(String(content.prefix(postLimit)))
                        .font(AppFont.regular(14))
                    + Text("... ").font(AppFont.regular(14))
                    + Text("Read more")
                        .font(AppFont.regular(14))
                        .foregroundStyle(.blue)
                } else {
                    Text(content).font(AppFont.regular(14))
                }
            }
    }
}

#Preview {
    ExpandableText(content: "I am a boy, I love to go home", postLimit: 30)
}
