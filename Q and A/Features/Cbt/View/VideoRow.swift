//
//  VideoRow.swift
//  Q and A
//
//  Created by GIGL-PC on 07/07/2026.
//

import SwiftUI

struct VideoRow: View {
   
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 0) {

                Rectangle()
                    .fill(LessonColor.videoThumbBg)
                    .frame(height: 150)
                    .overlay(alignment: .center) {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(LessonColor.playBg)
                            .frame(width: 52, height: 36)
                            .overlay(
                                Image(systemName: "play.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                            )
                    }
                    .overlay(alignment: .bottomTrailing) {
                        Text("YouTube")
                            .font(.system(size: 11))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.black.opacity(0.55))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .padding(10)
                    }
                    .clipShape(
                        .rect(topLeadingRadius: 12, bottomLeadingRadius: 0,
                              bottomTrailingRadius: 0, topTrailingRadius: 12)
                    )

                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(LessonColor.textPrimary)
                            .lineLimit(1)

                        Text("Watch on YouTube")
                            .font(.system(size: 12))
                            .foregroundColor(LessonColor.textSecondary)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 14))
                        .foregroundColor(LessonColor.textMuted)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
            }
            .contentShape(Rectangle())
            .background(LessonColor.itemBg)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(RowButtonStyle())
    }
    
}

#Preview {
    VideoRow(title: "Video Overview", action: {})
}

// MARK: - Shared row press style (subtle dim on tap, like Android's ripple)


