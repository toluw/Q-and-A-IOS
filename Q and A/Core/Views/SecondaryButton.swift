//
//  SecondaryButton.swift
//  Q and A
//
//  Created by GIGL-PC on 06/05/2026.
//

import SwiftUI

struct SecondaryButton: View {
    let buttonText: String
    let action: () -> Void
    let shape = RoundedRectangle(cornerRadius: 5)
        
        var body: some View {
            Button(action: action) {
                Text(buttonText)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .font(AppFont.medium(16))
                    .foregroundColor(.black)
                    .clipShape(shape)
                    .overlay(
                        shape.stroke(Color.black, lineWidth: 0.3)
                    )
            }
        }
}

#Preview {
    SecondaryButton(buttonText: "Continue", action: {})
}
