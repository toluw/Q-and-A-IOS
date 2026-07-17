//
//  SocialPostInputView.swift
//  Q and A
//
//  Created by GIGL-PC on 16/07/2026.
//

import SwiftUI

struct SocialPostInputView: View {
    
    @State private var text = ""
    let label: String

       let onSubmit: (String) -> Void
       let onSelectImage: () -> Void

       private var canSubmit: Bool {
           !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
       }

       var body: some View {
           VStack(spacing: 8) {
               
               Divider()
                   .background(LessonColor.border)

               TextEditor(text: $text)
                   .frame(minHeight: 30, maxHeight: 60)
                   .scrollContentBackground(.hidden)
                   .padding(.horizontal, 4)
                   .overlay(alignment: .topLeading) {
                       if text.isEmpty {
                           Text(label)
                               .foregroundStyle(.gray)
                               .padding(.top, 12)
                               .padding(.leading, 8)
                               .allowsHitTesting(false)
                       }
                   }

               HStack {

                   Button(action: onSelectImage) {
                       Image(systemName: "photo")
                           .font(.title3)
                   }

                   Spacer()

                   Button {
                       let value = text.trimmingCharacters(in: .whitespacesAndNewlines)
                       onSubmit(value)
                       text = ""
                   } label: {
                       Image("post_btn")
                           .renderingMode(.template)
                           .font(.title3)
                   }
                   .disabled(!canSubmit)
                   .foregroundStyle(canSubmit ? .blue : .gray.opacity(0.5))
               }
               .padding(.horizontal, 4)
           }
           .padding(10)
           
       }
    
}

#Preview {
    SocialPostInputView(label: "Join the conversation...", onSubmit: {text in}, onSelectImage: {})
}


