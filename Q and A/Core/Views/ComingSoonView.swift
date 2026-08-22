//
//  ComingSoonView.swift
//  Q and A
//
//  Created by GIGL-PC on 22/08/2026.
//

import SwiftUI

struct ComingSoonView: View {
    
    let config: ComingSoonConfig

       @State private var isAnimating = false

       init(config: ComingSoonConfig = .default) {
           self.config = config
       }
    
    var body: some View {
        VStack(spacing: 24) {
                   Spacer()

                   ZStack {
                       Circle()
                           .fill(config.accentColor.opacity(0.12))
                           .frame(width: 120, height: 120)

                       Image(systemName: config.icon)
                           .font(.system(size: 48, weight: .medium))
                           .foregroundStyle(config.accentColor)
                           .rotationEffect(.degrees(isAnimating ? 10 : -10))
                           .animation(
                               .easeInOut(duration: 1.4).repeatForever(autoreverses: true),
                               value: isAnimating
                           )
                   }

                   VStack(spacing: 8) {
                       Text(config.title)
                           .font(.title2.bold())
                           .multilineTextAlignment(.center)

                       Text(config.message)
                           .font(.subheadline)
                           .foregroundStyle(.secondary)
                           .multilineTextAlignment(.center)
                           .padding(.horizontal, 32)
                   }

                   if config.showNotifyButton {
                       Button(action: {
                           config.onNotifyTapped?()
                       }) {
                           Text("Notify Me")
                               .font(.headline)
                               .foregroundStyle(.white)
                               .padding(.vertical, 12)
                               .padding(.horizontal, 32)
                               .background(config.accentColor)
                               .clipShape(Capsule())
                       }
                       .padding(.top, 8)
                   }

                   Spacer()
                   Spacer()
               }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear { isAnimating = true }
    }
}

#Preview {
    ComingSoonView()
}
