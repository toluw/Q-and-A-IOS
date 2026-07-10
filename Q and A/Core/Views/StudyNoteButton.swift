//
//  StudyNoteButton.swift
//  Q and A
//
//  Created by GIGL-PC on 10/07/2026.
//

import SwiftUI

struct StudyNoteButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text(title)
                    .font(AppFont.medium(15))
                Image(systemName: "arrow.right")
                    .font(.system(size: 14))
            }
            .foregroundColor(LessonColor.buttonText)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(LessonColor.buttonBg)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    StudyNoteButton(title: "Continue to Questions", action: {})
}
