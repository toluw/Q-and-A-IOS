//
//  InstructionCallout.swift
//  Q and A
//
//  Created by GIGL-PC on 10/07/2026.
//

import SwiftUI

struct InstructionCallout: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "info.circle.fill")
                .font(.system(size: 18))
                .foregroundColor(LessonColor.accentText)
                .padding(.top, 1)

            Text(text)
                .font(.system(size: 13))
                .foregroundColor(LessonColor.accentText)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(LessonColor.accentBg)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

#Preview {
    InstructionCallout(text: "Instruction: How to get back home")
}
