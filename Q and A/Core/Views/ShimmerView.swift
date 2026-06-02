//
//  ShimmerView.swift
//  Q and A
//
//  Created by GIGL-PC on 02/06/2026.
//

import SwiftUI

struct ShimmerView: View {
    @State private var moveToRight = false

       var body: some View {

           Rectangle()
               .fill(Color.gray.opacity(0.3))
               .overlay {
                   LinearGradient(
                       colors: [
                           .clear,
                           .white.opacity(0.5),
                           .clear
                       ],
                       startPoint: .leading,
                       endPoint: .trailing
                   )
                   .offset(x: moveToRight ? 400 : -400)
                   .animation(
                       .linear(duration: 1.2)
                           .repeatForever(autoreverses: false),
                       value: moveToRight
                   )
                   .onAppear {
                       moveToRight = true
                   }
               }
               .clipped()
       }
}

#Preview {
    ShimmerView()
}
