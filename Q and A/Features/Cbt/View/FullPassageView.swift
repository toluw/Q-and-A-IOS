//
//  FullPassageView.swift
//  Q and A
//
//  Created by GIGL-PC on 01/06/2026.
//

import SwiftUI

struct FullPassageView: View {
    
    let passage: String
    
    var body: some View {
        if(!passage.isEmpty){
            styledPassage(passage).padding(.bottom, 16)
        }
    }
    
    
    private func styledPassage(_ text: String) -> Text {

        guard let colonIndex = text.firstIndex(of: ":") else {
            return Text(text)
                .font(AppFont.regular(16))
                .foregroundColor(Color("GreyText"))
        }

        let title = String(text[..<colonIndex])
        let body = String(text[text.index(after: colonIndex)...])

        return
            Text(title)
            .font(AppFont.semi_bold(16))
            .foregroundColor(Color("GreyText"))
            +
            Text(":" + body)
                .font(AppFont.regular(16))
                .foregroundColor(Color("GreyText"))
    }
}

#Preview {
    FullPassageView(passage: "Instruction: Tell us about a time when you worked very hsak jdnsk hjkhk jhdkq  jhkaNB JKSNDSKL HSJKLAN IOUORI LLCSA NK JDISO A jqdaodjo jlahl hj lakdol hlaj  kisjdldjn  skljhdl  iohklsdhsl hjlkahjl hl ahlknhl")
}
