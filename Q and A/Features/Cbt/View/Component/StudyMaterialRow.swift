//
//  StudyMaterialRow.swift
//  Q and A
//
//  Created by GIGL-PC on 07/07/2026.
//

import SwiftUI

struct StudyMaterialRow: View {
   
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {

                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(LessonColor.dangerBg)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "doc.text.fill")
                            .font(.system(size: 18))
                            .foregroundColor(LessonColor.dangerText)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text("Study material")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(LessonColor.textPrimary)

                    Text("Open PDF lesson")
                        .font(.system(size: 12))
                        .foregroundColor(LessonColor.textSecondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(LessonColor.textMuted)
            }
            .contentShape(Rectangle())
            .padding(16)
            .background(LessonColor.itemBg)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(RowButtonStyle())
    }
    
}

#Preview {
    StudyMaterialRow(action: {})
}
