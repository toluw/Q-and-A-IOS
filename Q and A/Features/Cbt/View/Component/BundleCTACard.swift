//
//  BundleCTACard.swift
//  Q and A
//
//  Created by GIGL-PC on 17/10/2026.
//


import SwiftUI

struct BundleCTACard: View {
    let bundleTitle: String
    let bundleContent: String
    let onViewBundle: () -> Void

    private let primaryRed = Color(red: 1, green: 0.267, blue: 0.267)
    private let navy = Color(red: 0.063, green: 0.141, blue: 0.322)
    private let lightPink = Color(red: 1, green: 0.953, blue: 0.953)

    var body: some View {
        HStack(spacing: 10) {

            // Bundle icon
            Image(systemName: "tag.fill")
                .font(.system(size: 24))
                .foregroundStyle(primaryRed)
                .frame(width: 28, height: 28)

            // Dynamic subject title
            Text("Unlock all \(bundleTitle) \(bundleContent.lowercased()) at a discount")
                .font(AppFont.medium(14))
                .foregroundStyle(navy)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            // View Bundle button
            Button(action: onViewBundle) {
                HStack(spacing: 4) {
                    Text("View")
                        .lineLimit(1)

                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                }
                .contentShape(Rectangle())
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .frame(height: 34)
                .background(primaryRed)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(.plain)
            .fixedSize(horizontal: true, vertical: false)
        }
        .padding(.horizontal, 14)
        .frame(minHeight: 64)
        .background(lightPink)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}


#Preview {
    BundleCTACard(bundleTitle: "Biology", bundleContent: "topics", onViewBundle: {})
}
