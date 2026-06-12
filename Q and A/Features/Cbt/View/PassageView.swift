//
//  PassageView.swift
//  Q and A
//
//  Created by GIGL-PC on 01/06/2026.
//

import SwiftUI

struct PassageView: View {
    

        let passage: String
        let passageImage: String?
        let passageVideo: String?
        let passageBook: String?

        let onReadMore: () -> Void

        private var hasAttachment: Bool {
            !(passageImage?.isEmpty ?? true)
            || passageVideo?.isValidYouTubeUrl() == true
            || convertGoogleDriveLinkToDirect(passageBook) != nil
        }

        private var shouldShowReadMore: Bool {
            passage.count > PASSAGE_NUM || hasAttachment
        }

        private var displayText: String {
            if passage.count > PASSAGE_NUM {
                return "\(String(passage.prefix(PASSAGE_NUM)))..Read more"
            }

            if hasAttachment {
                return "\(passage)..Read more"
            }

            return passage
        }

        var body: some View {

            if !passage.isEmpty {
                buildAttributedText()
                    .padding(.bottom, 16)
            }
        }

        @ViewBuilder
        private func buildAttributedText() -> some View {

            let readMoreText = "..Read more"

            if shouldShowReadMore {

                let contentText = displayText.replacingOccurrences(
                    of: readMoreText,
                    with: ""
                )

                (
                    styledPassage(contentText)
                    +
                    Text(readMoreText)
                        .foregroundColor(.blue)
                        .font(AppFont.medium(16))
                )
                .onTapGesture {
                    onReadMore()
                }

            } else {

                styledPassage(displayText)
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
    PassageView(passage: "Instruction: Tell us about a time when you worked very hsak jdnsk hjkhk jhdkq  jhkaNB JKSNDSKL HSJKLAN IOUORI LLCSA NK JDISO A jqdaodjo jlahl hj lakdol hlaj  kisjdldjn  skljhdl  iohklsdhsl hjlkahjl hl ahlknhl", passageImage: nil, passageVideo: nil, passageBook: nil, onReadMore: {})
}
