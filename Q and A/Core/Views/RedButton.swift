//
//  RedButton.swift
//  Q and A
//
//  Created by GIGL-PC on 24/11/2026.
//

import SwiftUI

struct RedButton: View {
    let buttonText: String
    let action: () -> Void
    private let primaryRed = Color(hex: "#FF4545")
        
        var body: some View {
            Button(action: action) {
                Text(buttonText)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .background(primaryRed)
                    .font(AppFont.semi_bold(16))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
        }
}

#Preview {
    RedButton(buttonText: "Pay now", action: {})
}
