//
//  PrimaryButton.swift
//  Q and A
//
//  Created by GIGL-PC on 24/03/2026.
//

import SwiftUI



struct PrimaryButton: View {
    
    let buttonText: String
    let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Text(buttonText)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .background(Color.black)
                    .font(AppFont.medium(16))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
        }
}

#Preview {
    PrimaryButton(buttonText: "Continue", action: {})
}
